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
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "CloudflareImages"),
    .testTarget(
      name: "CloudflareImagesTests",
      dependencies: ["CloudflareImages"]),
    .target(
      name: "CloudflareStream"),
    .testTarget(
      name: "CloudflareStreamTests",
      dependencies: ["CloudflareStream"]),
  ]
)
