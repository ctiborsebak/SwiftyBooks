// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Core",
  platforms: [
    .iOS(
      .v17
    )
  ],
  products: [
    .library(
      name: "Library",
      targets: ["Library"]
    ),
  ],
  dependencies: [
    .package(path: "../Domain"),
    .package(path: "../Theme"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.19.1"))
  ],
  targets: [
    .target(
      name: "Library",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Domain", package: "Domain"),
        .product(name: "Theme", package: "Theme"),
      ]
    ),
    .testTarget(
      name: "LibraryTests",
      dependencies: ["Library"]
    ),
  ]
)
