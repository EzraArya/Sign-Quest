// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Play",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Play",
            targets: ["Play"]),
    ],
    dependencies: [
        .package(path: "../SignQuestUI"),
        .package(path: "../SignQuestInterfaces"),
        .package(path: "../SignQuestModels"),
        .package(url: "https://github.com/ultralytics/yolo-ios-app.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Play",
            dependencies: [
                "SignQuestUI",
                "SignQuestInterfaces",
                "SignQuestModels",
                .product(name: "YOLO", package: "yolo-ios-app"),
            ],
            resources: [
                .copy("Model/yolo.mlmodel")
            ]
        ),
        .testTarget(
            name: "PlayTests",
            dependencies: ["Play"]
        ),
    ]
)
