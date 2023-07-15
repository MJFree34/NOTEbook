// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Common",
            targets: [
                "Common"
            ]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Common",
            dependencies: []
        ),
        .testTarget(
            name: "CommonTests",
            dependencies: [
                .target(name: "Common")
            ]
        )
    ]
)
