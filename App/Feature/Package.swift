// swift-tools-version: 6.1
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
      name: "VolumeCard",
      targets: ["VolumeCard"]
    ),
  ],
  dependencies: [
    .package(path: "../Domain"),
    .package(path: "../Shared"),
    .package(path: "../Theme"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.19.1"))
  ],
  targets: [
    .target(
      name: "VolumeCard",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Domain", package: "Domain"),
        .product(name: "Extensions", package: "Shared"),
        .product(name: "Theme", package: "Theme"),
      ]
    ),
    .testTarget(
      name: "VolumeCardTests",
      dependencies: ["VolumeCard"]
    ),
  ]
)
