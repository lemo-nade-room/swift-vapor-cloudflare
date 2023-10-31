import CloudflareLibrary
import Vapor

extension CloudflareStreamClient {

  /// Delete video
  ///
  /// @Links(visualStyle: compactGrid) {
  /// - https://developers.cloudflare.com/api/operations/stream-videos-delete-video
  /// }
  public func deleteVideo(identifier: String) async throws -> HTTPStatus {
    let response = try await client.delete(
      "https://api.cloudflare.com/client/v4/accounts/\(accountIdentifier)/stream/\(identifier)"
    ) { req in
      req.headers.bearerAuthorization = .init(token: apiToken)
      req.headers.contentType = .json
    }
    return response.status
  }
}
