// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "CodableXPC",
    products: [
        .library(
            name: "CodableXPC",
            targets: ["CodableXPC"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CodableXPC",
            dependencies: []),
        .testTarget(
            name: "CodableXPCTests",
            dependencies: ["CodableXPC"]),
    ]
)
