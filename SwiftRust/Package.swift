// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftRust",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "SwiftRust",
            targets: ["SwiftRust"]),
    ],
    targets: [
        .target(
            name: "SwiftRust",
            dependencies: ["Rust"]),
        .binaryTarget(
            name: "Rust",
            path: "../bundle.zip"
         ),
        .testTarget(
            name: "SwiftRustTests",
            dependencies: ["SwiftRust"]),
    ]
)
