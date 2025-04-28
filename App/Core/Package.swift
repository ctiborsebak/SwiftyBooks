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
    )
  ],
  dependencies: [
    .package(path: "../Data"),
    .package(path: "../Domain"),
    .package(path: "../Feature"),
    .package(path: "../Theme"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.19.1"))
  ],
  targets: [
    .target(
      name: "Library",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Domain", package: "Domain"),
        .product(name: "GoogleBooksClient", package: "Data"),
        .product(name: "Networking", package: "Data"),
        .product(name: "Theme", package: "Theme"),
        .product(name: "Volume", package: "Feature")
      ],
    ),
    .testTarget(
      name: "LibraryTests",
      dependencies: ["Library"]
    )
  ]
)
