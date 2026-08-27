// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-time-to-live-dependencies",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Time To Live Dependencies",
            targets: ["Time To Live Dependencies"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-compositions/swift-time-to-live.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-compositions/swift-clocks-dependencies.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-compositions/swift-dependencies.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-time.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Time To Live Dependencies",
            dependencies: [
                .product(name: "Time To Live", package: "swift-time-to-live"),
                .product(name: "Time To Live Store", package: "swift-time-to-live"),
                .product(name: "Clocks Dependencies", package: "swift-clocks-dependencies"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "Time Primitive", package: "swift-time"),
            ]
        ),
        .testTarget(
            name: "Time To Live Dependencies Tests",
            dependencies: [
                "Time To Live Dependencies",
                .product(name: "Dependencies Test Support", package: "swift-dependencies"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem
}
