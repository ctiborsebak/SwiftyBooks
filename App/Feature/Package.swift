// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Feature",
  platforms: [
    .iOS(
      .v17
    )
  ],
  products: [
    .library(
      name: "Volume",
      targets: ["Volume"]
    )
  ],
  dependencies: [
    .package(path: "../Domain"),
    .package(path: "../Shared"),
    .package(path: "../Theme"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.19.1"))
  ],
  targets: [
    .target(
      name: "Volume",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Domain", package: "Domain"),
        .product(name: "Shared", package: "Shared"),
        .product(name: "Theme", package: "Theme")
      ]
    ),
    .testTarget(
      name: "VolumeTests",
      dependencies: ["Volume"]
    )
  ]
)
