// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Theme",
  platforms: [
    .iOS(.v17)
  ],
  products: [
    .library(
      name: "Theme",
      targets: ["Theme"]
    ),
  ],
  targets: [
    .target(
      name: "Theme"
    ),
  ]
)
