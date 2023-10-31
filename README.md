# Swift Vapor Cloudflare

![LICENSE](https://img.shields.io/badge/license-MIT-brightgreen.svg)

swift-vapor-cloudflare is a library designed to provide an interface for interacting with Cloudflare Images and Cloudflare Stream using Vapor's Swift server-side web framework. The library encapsulates the necessary requests and responses to and from the Cloudflare Images API, simplifying the process of managing images and stream on Cloudflare's platform in a Vapor application.

## Features

### Cloudflare Images

- [Create authenticated direct upload URL V2](https://developers.cloudflare.com/api/operations/cloudflare-images-create-authenticated-direct-upload-url-v-2)
- [Delete image](https://developers.cloudflare.com/api/operations/cloudflare-images-delete-image)
- [Image details](https://developers.cloudflare.com/api/operations/cloudflare-images-image-details)
- [List images V2](https://developers.cloudflare.com/api/operations/cloudflare-images-list-images-v2)
- [Update image](https://developers.cloudflare.com/api/operations/cloudflare-images-update-image)

### Cloudflare Stream

- [Delete video](https://developers.cloudflare.com/api/operations/stream-videos-delete-video)
- [List videos](https://developers.cloudflare.com/api/operations/stream-videos-list-videos)
- [Retrieve video details](https://developers.cloudflare.com/api/operations/stream-videos-retrieve-video-details)
- [Storage use](https://developers.cloudflare.com/api/operations/stream-videos-storage-usage)
- [Upload videos via direct upload URLs](https://developers.cloudflare.com/api/operations/stream-videos-upload-videos-via-direct-upload-ur-ls)

## Installation

### Swift Package Manager

Add the following line to your `Package.swift` file in the `dependencies` array:

```swift
// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "Project",
    platforms: [
       .macOS(.v12)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        ...
        .package(url: "https://github.com/lemo-nade-room/swift-vapor-cloudflare.git", from: "0.0.2")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "CloudflareImages", package: "swift-vapor-cloudflare"),
                .product(name: "CloudflareStream", package: "swift-vapor-cloudflare"),
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides/blob/main/docs/building.md#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .executableTarget(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
```

## Usage

### Configuration

Firstly, configure the `CloudflareImagesClient` in your Vapor application:

```swift
import Vapor
import CloudflareImages

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.cloudflareImages = .init(
        client: app.client,
        accountIdentifier: Environment.get("CLOUDFLARE_ACCOUNT_IDENTIFIER")!,
        apiToken: Environment.get("CLOUDFLARE_API_TOKEN")!
    )

    app.cloudflareStream = .init(
        client: app.client,
        accountIdentifier: Environment.get("CLOUDFLARE_ACCOUNT_IDENTIFIER")!,
        apiToken: Environment.get("CLOUDFLARE_API_TOKEN")!
    )

    // register routes
    try routes(app)
}
```

### Making Requests

With the `CloudflareImagesClient` configured, you can now make requests to the Cloudflare Images API. Here are some examples:

```swift
// Create an authenticated direct upload URL
let uploadURL = try await app.cloudflareImages.createAuthenticatedDirectUploadURLV2(
    expiry: 3 /*min*/ * 60 /*sec/min*/,
    requireSignedURLs: true
)

// List images
let images = try await app.cloudflareImages.listImagesV2()

// Get image details
let imageDetails = try await app.cloudflareImages.imageDetails(
    imageId: "139999a3-edd4-4988-1a1e-f457ccc43401"
)

// Delete an image
try await app.cloudflareImages.deleteImage(
    imageId: "ccbc6bb0-8796-4559-3af6-9be5b8b3ce01"
)

// Update an image
try await app.cloudflareImages.updateImage(
    imageId: "fe5a7718-f114-43a7-fb4e-2e554c290f00",
    metadata: ["hello": "world"],
    requireSignedURLs: true
)
```

## License

SwiftVaporCloudflareImages is available under the MIT license. See the LICENSE file for more info.
