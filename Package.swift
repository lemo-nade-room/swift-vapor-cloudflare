// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "swift-vapor-cloudflare",
  platforms: [.macOS(.v12)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "CloudflareImages",
      targets: ["CloudflareImages"]),
    .library(
      name: "CloudflareStream",
      targets: ["CloudflareStream"]),
  ],
  dependencies: [
    // 💧 A server-side Swift web framework.
    .package(url: "https://github.com/vapor/vapor.git", from: "4.83.1")
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "CloudflareImages",
      dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .target(name: "CloudflareLibrary"),
      ]),
    .testTarget(
      name: "CloudflareImagesTests",
      dependencies: [
        "CloudflareImages",
        .product(name: "XCTVapor", package: "vapor"),
      ]),

    .target(
      name: "CloudflareStream",
      dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .target(name: "CloudflareLibrary"),
      ]),
    .testTarget(
      name: "CloudflareStreamTests",
      dependencies: [
        "CloudflareStream",
        .product(name: "XCTVapor", package: "vapor"),
      ]),

    .target(
      name: "CloudflareLibrary",
      dependencies: [
        .product(name: "Vapor", package: "vapor")
      ]),
  ]
)
