import CloudflareLibrary
import Vapor

extension CloudflareImagesClient {

  /// Create authenticated direct upload URL V2
  ///
  /// @Links(visualStyle: compactGrid) {
  /// - https://developers.cloudflare.com/api/operations/cloudflare-images-create-authenticated-direct-upload-url-v-2
  /// }
  public func createAuthenticatedDirectUploadURLV2(
    expiry: Date? = nil,
    metadata: [String: String]? = nil,
    requireSignedURLs: Bool? = nil
  ) async throws -> CreateAuthenticatedDirectUploadURLV2 {
    let reqContent = RequestContent(
      expiry: expiry.map { dateFormatterRFC3339.string(from: $0) },
      metadata: metadata,
      requireSignedURLs: requireSignedURLs
    )
    let response = try await client.post(
      "https://api.cloudflare.com/client/v4/accounts/\(accountIdentifier)/images/v2/direct_upload"
    ) { req in
      req.headers.bearerAuthorization = bearer
      try req.content.encode(reqContent, as: .formData)
    }
    return try response.content.decode(
      CreateAuthenticatedDirectUploadURLV2.self, using: jsonDecoder)
  }

  /// Create authenticated direct upload URL V2
  ///
  /// @Links(visualStyle: compactGrid) {
  /// - https://developers.cloudflare.com/api/operations/cloudflare-images-create-authenticated-direct-upload-url-v-2
  /// }
  public func createAuthenticatedDirectUploadURLV2(
    expiry: TimeInterval? = nil,
    metadata: [String: String]? = nil,
    requireSignedURLs: Bool? = nil
  ) async throws -> CreateAuthenticatedDirectUploadURLV2 {
    try await createAuthenticatedDirectUploadURLV2(
      expiry: expiry.map { Date(timeIntervalSinceNow: $0) },
      metadata: metadata,
      requireSignedURLs: requireSignedURLs
    )
  }
}

private struct RequestContent: Content {
  var expiry: String?
  var metadata: [String: String]?
  var requireSignedURLs: Bool?
}

public struct CreateAuthenticatedDirectUploadURLV2: Hashable, Content,
  CloudflareImagesResponseContent
{
  public var errors: [ResponseError]
  public var messages: [ResponseMessage]?
  public var result: Result?
  public var success: Bool

  public init(
    errors: [ResponseError],
    messages: [ResponseMessage]? = nil,
    result: Result? = nil,
    success: Bool
  ) {
    self.errors = errors
    self.messages = messages
    self.result = result
    self.success = success
  }

  public struct Result: Hashable, Content {
    public var id: String?
    public var uploadURL: String?

    public init(id: String? = nil, uploadURL: String? = nil) {
      self.id = id
      self.uploadURL = uploadURL
    }
  }
}
