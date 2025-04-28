// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Shared",
  platforms: [
    .iOS(
      .v17
    )
  ],
  products: [
    .library(
      name: "Shared",
      targets: ["Shared"]
    ),
  ],
  dependencies: [
    .package(path: "../Domain"),
  ],
  targets: [
    .target(
      name: "Shared",
      dependencies: [
        .product(name: "Domain", package: "Domain"),
      ],
    ),
    .testTarget(
      name: "SharedTests",
      dependencies: [
        "Shared"
      ]
    )
  ]
)
