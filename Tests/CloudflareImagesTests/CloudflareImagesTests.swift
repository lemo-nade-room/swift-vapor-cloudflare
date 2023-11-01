import XCTVapor

@testable import CloudflareImages

final class CloudflareImagesTests: XCTestCase {
  func testListImagesV2() async throws {
    let app = Application(.testing)
    defer { app.shutdown() }
    app.cloudflareImages = .init(
      client: app.client,
      accountIdentifier: accountIdentifier,
      apiToken: apiToken
    )

    let result = try await app.cloudflareImages.listImagesV2()

    print("⭐️")
    print(result)
  }

  func testCreateAuthenticatedDirectUploadURLV2() async throws {
    let app = Application(.testing)
    defer { app.shutdown() }
    app.cloudflareImages = .init(
      client: app.client,
      accountIdentifier: accountIdentifier,
      apiToken: apiToken
    )

    let result = try await app.cloudflareImages.createAuthenticatedDirectUploadURLV2(
      expiry: 3 /*min*/ * 60 /*sec/min*/
    )

    print("💚 direct")
    print(result)
  }

  func testImageDetails() async throws {
    let app = Application(.testing)
    defer { app.shutdown() }
    app.cloudflareImages = .init(
      client: app.client,
      accountIdentifier: accountIdentifier,
      apiToken: apiToken
    )

    let detail = try await app.cloudflareImages.imageDetails(
      imageId: "eb32dce5-11c0-4cae-0c8d-9103d15b7100")

    print("💛")
    print(detail)
  }

  func testDeleteImage() async throws {
    let app = Application(.testing)
    defer { app.shutdown() }
    app.cloudflareImages = .init(
      client: app.client,
      accountIdentifier: accountIdentifier,
      apiToken: apiToken
    )

    _ = try await app.cloudflareImages.deleteImage(
      imageId: "ccbc6bb0-8796-4559-3af6-9be5b8b3ce01")

  }

  func testUpdat4eImage() async throws {
    let app = Application(.testing)
    defer { app.shutdown() }
    app.cloudflareImages = .init(
      client: app.client,
      accountIdentifier: accountIdentifier,
      apiToken: apiToken
    )

    _ = try await app.cloudflareImages.updateImage(
      imageId: "fe5a7718-f114-43a7-fb4e-2e554c290f00",
      metadata: ["hello": "world"],
      requireSignedURLs: true
    )
  }
}
