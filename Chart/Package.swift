// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Chart",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "ChartDomain",
            targets: [
                "ChartDomain"
            ]
        ),
        .library(
            name: "ChartUI",
            targets: [
                "ChartUI"
            ]
        )
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../CommonUI"),
        .package(path: "../Storage")
    ],
    targets: [
        .target(
            name: "ChartDomain",
            dependencies: [
                .product(
                    name: "Common",
                    package: "Common"
                ),
                .product(
                    name: "Storage",
                    package: "Storage"
                )
            ]
        ),
        .target(
            name: "ChartUI",
            dependencies: [
                .target(
                    name: "ChartDomain"
                ),
                .product(
                    name: "Common",
                    package: "Common"
                ),
                .product(
                    name: "CommonUI",
                    package: "CommonUI"
                )
            ]
        ),
        .testTarget(
            name: "ChartTests",
            dependencies: [
                .target(
                    name: "ChartDomain"
                )
            ]
        )
    ]
)
