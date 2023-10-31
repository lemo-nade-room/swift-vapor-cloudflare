import XCTVapor

@testable import CloudflareStream

final class CloudflareSteamTests: XCTestCase {

  func testListVideos() async throws {
    let app = prepareApplication()
    defer { app.shutdown() }

    _ = try await app.cloudflareStream.listVideos()
  }

  func testUploadVideosViaDirectUploadURLs() async throws {
    let app = prepareApplication()
    defer { app.shutdown() }

    _ = try await app.cloudflareStream.uploadVideosViaDirectUploadURLsExpiryByInterval(
      expiry: 3 * 60, maxDurationSeconds: 30)
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
