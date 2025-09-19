// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dub",
    platforms: [
      .iOS(.v16),
      .macCatalyst(.v16),
      .macOS(.v13),
    ],
    products: [
        .library(name: "Dub", targets: ["Dub"]),
    ],
    dependencies: [
      .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.4.5"),
    ],
    targets: [
        .target(
            name: "Dub",
            resources: [
                .copy("PrivacyInfo.xcprivacy")
            ]),
        .testTarget(
            name: "DubTests",
            dependencies: ["Dub"]
        )
    ]
)
