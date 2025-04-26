// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Data",
  platforms: [
    .iOS(
      .v17
    )
  ],
  products: [
    .library(
      name: "Networking",
      targets: ["Networking"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-dependencies", .upToNextMajor(from: "1.9.2"))
  ],
  targets: [
    .target(
      name: "Networking",
      dependencies: [
        .product(name: "Dependencies", package: "swift-dependencies"),
      ]
    ),
    .testTarget(
      name: "NetworkingTests",
      dependencies: ["Networking"]
    ),
  ]
)
