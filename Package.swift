// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */


import PackageDescription

let package = Package(
    name: "yoga",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "YogaKitSwift",
            targets: ["YogaKitSwift"]),
        .library(
            name: "YogaKit",
            targets: ["YogaKit"]),
        .library(
            name: "Yoga",
            targets: ["Yoga"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "YogaKitSwift",
            dependencies: ["YogaKit", "Yoga"],
            path: ".",
            sources: ["YogaKit/YogaKit.Swift"],
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("yoga")
            ]),
        .target(
            name: "YogaKit",
            dependencies: ["Yoga"],
            path: ".",
            sources: ["YogaKit/Source"],
            publicHeadersPath: "YogaKit/Source/include",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("yoga")
            ]),
        .target(
            name: "Yoga",
            path: ".",
            exclude: ["yoga/Yoga.h"],
            sources: ["yoga"],
            publicHeadersPath: "yoga/include",
            cSettings: [
                .headerSearchPath(".")
            ])
    ],
    cxxLanguageStandard: CXXLanguageStandard(rawValue: "c++20")
)
