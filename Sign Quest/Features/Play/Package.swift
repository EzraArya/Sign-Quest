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
        .package(path: "../SignQuestCore"),
        .package(url: "https://github.com/ultralytics/yolo-ios-app.git", branch: "main"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.14.0")
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
                "SignQuestCore",
                .product(name: "YOLO", package: "yolo-ios-app"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
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
