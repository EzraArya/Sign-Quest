// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dashboard",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Dashboard",
            targets: ["Dashboard"]),
    ],
    dependencies: [
        .package(path: "../SignQuestUI"),
        .package(path: "../SignQuestInterfaces")
    ],

    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Dashboard",
            dependencies: ["SignQuestUI", "SignQuestInterfaces"]
        ),
        .testTarget(
            name: "DashboardTests",
            dependencies: ["Dashboard"]
        ),
    ]
)
