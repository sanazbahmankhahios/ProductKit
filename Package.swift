// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProductKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v14),
        .watchOS(.v10)
    ],
    products: [
        .library(
            name: "ProductKit",
            targets: ["ProductKit"]
        )
    ],
//    dependencies: [
//       
//       .package(url: "https://github.com/onevcat/Kingfisher", .upToNextMajor(from: "8.6.1")),
//    ],
    targets: [
        .target(
            name: "ProductKit"
        ),
        .testTarget(
            name: "ProductKitTests",
            dependencies: ["ProductKit"]
        )
    ]
)
