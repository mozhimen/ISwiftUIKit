// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ISwiftUIKit.CoordinateLayout",
    platforms: [
        .macOS(.v10_15),.iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ISwiftUIKit.CoordinateLayout",
            targets: ["ISwiftUIKit.CoordinateLayout"]),
    ],
    dependencies: [
        .package(url: "https://github.com/siteline/swiftui-introspect", from: "1.4.0-beta.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ISwiftUIKit.CoordinateLayout",
            dependencies: [
                .product(name: "SwiftUIIntrospect", package: "swiftui-introspect")
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]),
    ]
)
