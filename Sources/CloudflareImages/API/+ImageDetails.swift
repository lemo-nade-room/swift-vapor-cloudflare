import CloudflareLibrary
import Vapor

extension CloudflareImagesClient {

  /// Get Image Details
  ///
  /// @Links(visualStyle: compactGrid) {
  /// - https://developers.cloudflare.com/api/operations/cloudflare-images-image-details
  /// }
  public func imageDetails(imageId: String) async throws -> ImageDetails {
    let response = try await client.get(
      "https://api.cloudflare.com/client/v4/accounts/\(accountIdentifier)/images/v1/\(imageId)"
    ) { req in
      req.headers.bearerAuthorization = .init(token: apiToken)
      req.headers.contentType = .json
    }
    return try response.content.decode(ImageDetails.self, using: jsonDecoder)
  }
}

public struct ImageDetails: Hashable, Content, CloudflareImagesResponseContent {
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
    public var filename: String?
    public var id: String?
    public var meta: [String: String]?
    public var requireSignedURLs: Bool?
    public var uploaded: Date?
    public var variants: [String]?
    public var draft: Bool?

    public init(
      filename: String? = nil,
      id: String? = nil,
      meta: [String: String]? = nil,
      requireSignedURLs: Bool? = nil,
      uploaded: Date? = nil,
      variants: [String]? = nil,
      draft: Bool? = nil
    ) {
      self.filename = filename
      self.id = id
      self.meta = meta
      self.requireSignedURLs = requireSignedURLs
      self.uploaded = uploaded
      self.variants = variants
      self.draft = draft
    }
  }
}
