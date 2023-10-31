import CloudflareLibrary
import Vapor

extension CloudflareImagesClient {

  /// Delete Image
  ///
  /// @Links(visualStyle: compactGrid) {
  /// - https://developers.cloudflare.com/api/operations/cloudflare-images-delete-image
  /// }
  public func deleteImage(imageId: String) async throws -> DeleteImageResponse {
    let response = try await client.delete(
      "https://api.cloudflare.com/client/v4/accounts/\(accountIdentifier)/images/v1/\(imageId)",
      headers: [
        "Authorization": "Bearer \(apiToken)",
        "Content-Type": "application/json",
      ]
    )
    return try response.content.decode(DeleteImageResponse.self, using: jsonDecoder)
  }
}

public struct DeleteImageResponse: Hashable, Content, CloudflareImagesResponseContent {
  public var errors: [ResponseError]
  public var messages: [ResponseMessage]
  public var success: Bool
  public var result: Result?

  public init(
    errors: [ResponseError],
    messages: [ResponseMessage],
    success: Bool
  ) {
    self.errors = errors
    self.messages = messages
    self.success = success
  }

  public struct Result: Hashable, Codable {}
}
