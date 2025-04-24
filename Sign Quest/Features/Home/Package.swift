// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    dependencies: [
        .package(path: "../SignQuestUI"),
        .package(path: "../SignQuestInterfaces"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Home",
            dependencies: ["SignQuestUI", "SignQuestInterfaces"],
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]
        ),
    ]
)
