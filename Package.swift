// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
//  Copyright 2020 Grabtaxi Holdings PTE LTE (GRAB), All rights reserved.
//  Use of this source code is governed by an MIT-style license that can be found in the LICENSE file
//

import PackageDescription

let package = Package(
    name: "SwiftLeakCheck",
    platforms: [
        .macOS(.v10_15) // Minimum deployment target macOS 10.15 or later
    ],
    products: [
        .library(name: "SwiftLeakCheck", targets: ["SwiftLeakCheck"]),
        .executable(name: "SwiftLeakChecker", targets: ["SwiftLeakChecker"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax", .exact("508.0.1")),
    ],
    targets: [
        .executableTarget(
            name: "SwiftLeakChecker",
            dependencies: [
                "SwiftLeakCheck",
                .product(name: "SwiftSyntaxParser", package: "swift-syntax")
            ]
        ),
        .target(
            name: "SwiftLeakCheck",
            dependencies: [
                .product(name: "SwiftSyntaxParser", package: "swift-syntax")
            ]
        ),
        .testTarget(
            name: "SwiftLeakCheckTests",
            dependencies: ["SwiftLeakCheck"]
        )
    ]
)
