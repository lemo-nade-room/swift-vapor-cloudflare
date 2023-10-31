import XCTVapor

@testable import CloudflareImages

final class CloudflareImagesTests: XCTestCase {
  //  func testListImagesV2() async throws {
  //    let app = Application(.testing)
  //    defer { app.shutdown() }
  //    app.cloudflareImages = .init(
  //      client: app.client,
  //      accountIdentifier: Environment.get("CLOUDFLARE_IMAGES_ACCOUNT_IDENTIFIER")!,
  //      apiToken: Environment.get("CLOUDFLARE_IMAGES_API_TOKEN")!
  //    )
  //
  //    _ = try await app.cloudflareImages.listImagesV2()
  //  }
  //
  //  func testCreateAuthenticatedDirectUploadURLV2() async throws {
  //    let app = Application(.testing)
  //    defer { app.shutdown() }
  //    app.cloudflareImages = .init(
  //      client: app.client,
  //      accountIdentifier: Environment.get("CLOUDFLARE_IMAGES_ACCOUNT_IDENTIFIER")!,
  //      apiToken: Environment.get("CLOUDFLARE_IMAGES_API_TOKEN")!
  //    )
  //
  //    _ = try await app.cloudflareImages.createAuthenticatedDirectUploadURLV2(
  //      expiry: 3 /*min*/ * 60 /*sec/min*/,
  //      requireSignedURLs: true
  //    )
  //  }
  //
  //  func testImageDetails() async throws {
  //    let app = Application(.testing)
  //    defer { app.shutdown() }
  //    app.cloudflareImages = .init(
  //      client: app.client,
  //      accountIdentifier: Environment.get("CLOUDFLARE_IMAGES_ACCOUNT_IDENTIFIER")!,
  //      apiToken: Environment.get("CLOUDFLARE_IMAGES_API_TOKEN")!
  //    )
  //
  //    _ = try await app.cloudflareImages.imageDetails(
  //      imageId: "139999a3-edd4-4988-1a1e-f457ccc43401")
  //  }
  //
  //  func testDeleteImage() async throws {
  //    let app = Application(.testing)
  //    defer { app.shutdown() }
  //    app.cloudflareImages = .init(
  //      client: app.client,
  //      accountIdentifier: Environment.get("CLOUDFLARE_IMAGES_ACCOUNT_IDENTIFIER")!,
  //      apiToken: Environment.get("CLOUDFLARE_IMAGES_API_TOKEN")!
  //    )
  //
  //    _ = try await app.cloudflareImages.deleteImage(
  //      imageId: "ccbc6bb0-8796-4559-3af6-9be5b8b3ce01")
  //
  //  }
  //
  //  func testUpdat4eImage() async throws {
  //    let app = Application(.testing)
  //    defer { app.shutdown() }
  //    app.cloudflareImages = .init(
  //      client: app.client,
  //      accountIdentifier: Environment.get("CLOUDFLARE_IMAGES_ACCOUNT_IDENTIFIER")!,
  //      apiToken: Environment.get("CLOUDFLARE_IMAGES_API_TOKEN")!
  //    )
  //
  //    _ = try await app.cloudflareImages.updateImage(
  //      imageId: "fe5a7718-f114-43a7-fb4e-2e554c290f00",
  //      metadata: ["hello": "world"],
  //      requireSignedURLs: true
  //    )
  //  }
}
