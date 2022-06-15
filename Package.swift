// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "encore-swift",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        .library(name: "Encore", targets: ["Encore"]),
    ],
    targets: [
        .target(name: "Encore", dependencies: [
            .product(name: "Algorithms", package: "swift-algorithms"),
            .product(name: "Builders", package: "swift-builders"),
            .product(name: "CasePaths", package: "swift-case-paths"),
            .product(name: "CollectionConcurrencyKit", package: "CollectionConcurrencyKit"),
            .product(name: "CustomDump", package: "swift-custom-dump"),
            .target(name: "DateTimeOnly"),
            .target(name: "Do"),
            .target(name: "Extensions"),
            .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
            .product(name: "LegibleError", package: "LegibleError"),
            .product(name: "MobileProvision", package: "MobileProvision", condition: .when(platforms: [.iOS, .macOS, .tvOS])),
            .target(name: "NilGuardingOperators"),
            .product(name: "NonEmpty", package: "swift-nonempty"),
            .product(name: "PeriodDuration", package: "PeriodDuration"),
            .product(name: "PreciseDecimal", package: "PreciseDecimal"),
            .target(name: "RuntimeError"),
            .product(name: "Tagged", package: "swift-tagged"),
            .target(name: "UnwrapTuple"),
            .product(name: "Version", package: "Version"),
        ]),
    ]
)

// MARK: - Sources/Extensions

package.targets += [
    .target(
        name: "Extensions",
        dependencies: [
            .product(name: "Algorithms", package: "swift-algorithms"),
            .target(name: "DateTimeOnly"),
            .target(name: "Do"),
            .target(name: "NilGuardingOperators"),
            .product(name: "PeriodDuration", package: "PeriodDuration"),
            .product(name: "Tagged", package: "swift-tagged"),
            .product(name: "Version", package: "Version"),
        ],
        path: "Sources/Extensions"
    ),
]

// MARK: - Tests/Extensions

package.targets += [
    .testTarget(
        name: "ExtensionsTests",
        dependencies: [
            .target(name: "Extensions"),
        ],
        path: "Tests/Extensions"
    ),
]

// MARK: - Sources/Foundation

package.targets += [
    .target(
        name: "DateTimeOnly",
        path: "Sources/Foundation/DateTimeOnly"
    ),
    .target(
        name: "RuntimeError",
        path: "Sources/Foundation/RuntimeError"
    ),
]

package.dependencies += [
    .package(url: "https://github.com/mxcl/LegibleError", from: "1.0.6"),
    .package(url: "https://github.com/CrazyFanFan/MobileProvision", from: "0.0.2"),
    .package(url: "https://github.com/davdroman/PeriodDuration", from: "0.13.0"),
    .package(url: "https://github.com/davdroman/PreciseDecimal", branch: "main"),
    .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "0.3.2"),
    .package(url: "https://github.com/mxcl/Version", from: "2.0.1"),
]

// MARK: - Tests/Foundation

package.targets += [
    .testTarget(
        name: "DateTimeOnlyTests",
        dependencies: [
            .target(name: "DateTimeOnly"),
            .product(name: "XCTJSONKit", package: "XCTJSONKit"),
        ],
        path: "Tests/Foundation/DateTimeOnlyTests"
    ),
    .testTarget(
        name: "RuntimeErrorTests",
        dependencies: [
            .target(name: "RuntimeError"),
        ],
        path: "Tests/Foundation/RuntimeErrorTests"
    ),
]

package.dependencies += [
    .package(url: "https://github.com/davdroman/XCTJSONKit", branch: "main"),
]

// MARK: - Sources/Swift

package.targets += [
    .target(
        name: "Do",
        path: "Sources/Swift/Do",
        exclude: ["Do.swift.gyb"]
    ),
    .target(
        name: "NilGuardingOperators",
        path: "Sources/Swift/NilGuardingOperators"
    ),
    .target(
        name: "UnwrapTuple",
        path: "Sources/Swift/UnwrapTuple",
        exclude: ["UnwrapTuple.swift.gyb"]
    ),
]

package.dependencies += [
    .package(url: "https://github.com/JohnSundell/CollectionConcurrencyKit", from: "0.2.0"),
    .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
    .package(url: "https://github.com/davdroman/swift-builders", from: "0.2.0"),
    .package(url: "https://github.com/pointfreeco/swift-case-paths", from: "0.9.0"),
    .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "0.5.0"),
    .package(url: "https://github.com/pointfreeco/swift-nonempty", from: "0.4.0"),
    .package(url: "https://github.com/pointfreeco/swift-tagged", from: "0.7.0"),
]

// MARK: - Tests/Swift

package.targets += [
    .testTarget(
        name: "DoTests",
        dependencies: [
            .target(name: "Do"),
        ],
        path: "Tests/Swift/DoTests"
    ),
    .testTarget(
        name: "NilGuardingOperatorsTests",
        dependencies: [
            .product(name: "ErrorAssertions", package: "ErrorAssertions"),
            .product(name: "ErrorAssertionExpectations", package: "ErrorAssertions"),
            .target(name: "NilGuardingOperators"),
        ],
        path: "Tests/Swift/NilGuardingOperatorsTests"
    ),
]

package.dependencies += [
    .package(url: "https://github.com/SlaunchaMan/ErrorAssertions", from: "0.4.0"),
]
