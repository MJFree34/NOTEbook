// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "CommonUI",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "CommonUI",
            targets: [
                "CommonUI"
            ]
        )
    ],
    dependencies: [
        .package(path: "../Common")
    ],
    targets: [
        .target(
            name: "CommonUI",
            dependencies: [
                .product(
                    name: "Common",
                    package: "Common"
                )
            ]
        ),
        .testTarget(
            name: "CommonUITests",
            dependencies: [
                .target(name: "CommonUI")
            ]
        )
    ]
)
