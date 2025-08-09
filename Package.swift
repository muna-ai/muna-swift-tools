// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "MunaTools",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .plugin(
            name: "MunaEmbed",
            targets: ["Embed Predictors", "Bootstrap Project"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
        .package(url: "https://github.com/tuist/XcodeProj.git", from: "9.5.0")
    ],
    targets: [
        .executableTarget(
            name: "MunaEmbedder",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "XcodeProj", package: "XcodeProj")
            ]
        ),
        .plugin(
            name: "Bootstrap Project",
            capability: .command(
                intent: .custom(
                    verb: "muna-bootstrap",
                    description: "Bootstrap Muna in your iOS app target."
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "Allow Muna write the Muna configuration template.")
                ],
            ),
            path: "Plugins/Bootstrap"
        ),
        .plugin(
            name: "Embed Predictors",
            capability: .command(
                intent: .custom(
                    verb: "muna-embed",
                    description: "Embed predictors into your app bundle."
                ),
                permissions: [
                    .allowNetworkConnections(
                        scope: .all(ports: [80, 443]),
                        reason: "Allow Muna to download and embed predictors into your app."
                    ),
                    .writeToPackageDirectory(reason: "Allow Muna to embed predictors into your app.")
                ]
            ),
            dependencies: ["MunaEmbedder"],
            path: "Plugins/Embed"
        )
    ]
)
