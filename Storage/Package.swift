// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "Storage",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Storage",
            targets: [
                "Storage"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Storage",
            dependencies: []
        ),
        .testTarget(
            name: "StorageTests",
            dependencies: [
                .target(name: "Storage")
            ]
        )
    ]
)
