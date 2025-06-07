// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Leaderboard",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Leaderboard",
            targets: ["Leaderboard"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "../SignQuestUI"),
        .package(path: "../SignQuestInterfaces"),
        .package(path: "../SignQuestModels"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.14.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Leaderboard",
            dependencies: [
                "SignQuestUI",
                "SignQuestInterfaces",
                "SignQuestModels",
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
            ],
            resources: [
                .process("Asset")
            ]
        ),
        .testTarget(
            name: "LeaderboardTests",
            dependencies: ["Leaderboard"]
        ),
    ]
)
