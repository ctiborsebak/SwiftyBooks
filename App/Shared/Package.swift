// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Shared",
  products: [
    .library(
      name: "Extensions",
      targets: ["Extensions"]
    ),
  ],
  targets: [
    .target(
      name: "Extensions"
    ),
    .testTarget(
      name: "ExtensionsTests",
      dependencies: ["Extensions"]
    ),
  ]
)
