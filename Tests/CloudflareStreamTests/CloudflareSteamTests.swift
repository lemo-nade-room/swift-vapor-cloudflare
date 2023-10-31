import XCTVapor

@testable import CloudflareStream

final class CloudflareSteamTests: XCTestCase {

  func testListVideos() async throws {
    let app = prepareApplication()
    defer { app.shutdown() }

    let result = try await app.cloudflareStream.listVideos()

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
