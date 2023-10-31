import CloudflareLibrary
import Vapor

extension CloudflareImagesClient {

  /// Update Image
  ///
  /// @Links(visualStyle: compactGrid) {
  /// - https://developers.cloudflare.com/api/operations/cloudflare-images-update-image
  /// }
  public func updateImage(
    imageId: String,
    metadata: [String: String]? = nil,
    requireSignedURLs: Bool? = nil
  ) async throws -> UpdateImageResponse {
    let reqContent = UpdateImageRequestContent(
      metadata: metadata,
      requireSignedURLs: requireSignedURLs
    )
    let response = try await client.patch(
      "https://api.cloudflare.com/client/v4/accounts/\(accountIdentifier)/images/v1/\(imageId)",
      headers: [
        "Authorization": "Bearer \(apiToken)",
        "Content-Type": "application/json",
      ],
      content: reqContent
    )
    return try response.content.decode(UpdateImageResponse.self, using: jsonDecoder)
  }

}

private struct UpdateImageRequestContent: Content {
  var metadata: [String: String]?
  var requireSignedURLs: Bool?
}

public struct UpdateImageResponse: Hashable, Content, CloudflareImagesResponseContent {
  public var errors: [ResponseError]
  public var messages: [ResponseMessage]
  public var result: Result?
  public var success: Bool

  public init(
    errors: [ResponseError],
    messages: [ResponseMessage],
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
