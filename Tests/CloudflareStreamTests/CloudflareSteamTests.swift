import XCTVapor

@testable import CloudflareStream

final class CloudflareSteamTests: XCTestCase {

  func testListVideos() async throws {
    let app = prepareApplication()
    defer { app.shutdown() }

    let result = try await app.cloudflareStream.listVideos()

    print(try result.requireResult)
  }

  func testUploadVideosViaDirectUploadURLs() async throws {
    let app = prepareApplication()
    defer { app.shutdown() }

    _ = try await app.cloudflareStream.uploadVideosViaDirectUploadURLsExpiryByInterval(
      expiry: 3 * 60, maxDurationSeconds: 30)
  }

  func testStorageUse() async throws {
    let app = prepareApplication()
    defer { app.shutdown() }

    _ = try await app.cloudflareStream.storageUse()
  }

  func testDeleteVideo() async throws {
    let app = prepareApplication()
    defer { app.shutdown() }

    _ = try await app.cloudflareStream.deleteVideo(identifier: "7498fcea28faac05512840d03217bef2")
  }

  func testRetrieveVideoDetails() async throws {
    let app = prepareApplication()
    defer { app.shutdown() }

    let result = try await app.cloudflareStream.retrieveVideoDetails(
      identifier: "1d195ed628a9935bdff7cf272d82d399")

    print(result)
  }

  private func prepareApplication() -> Application {
    let app = Application(.testing)
    app.cloudflareStream = .init(
      client: app.client,
      accountIdentifier: accountIdentifier,
      apiToken: apiToken
    )
    return app
  }
}
