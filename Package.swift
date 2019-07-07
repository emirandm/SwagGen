// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "SwagGen",
    products: [
        .executable(name: "swaggen", targets: ["SwagGen"]),
        .library(name: "SwagGenKit", targets: ["SwagGenKit"]),
        .library(name: "Swagger", targets: ["Swagger"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/PathKit.git", .exact("0.9.2")),
        .package(url: "https://github.com/jakeheis/SwiftCLI", .exact("5.2.2")),
        .package(url: "https://github.com/stencilproject/Stencil.git", .exact("0.13.1")),
        .package(url: "https://github.com/jpsim/Yams.git", .exact("0.5.0")),
        .package(url: "https://github.com/yonaskolb/JSONUtilities.git", .exact("4.2.0")),
        .package(url: "https://github.com/kylef/Spectre.git", .exact("0.9.0")),
        .package(url: "https://github.com/onevcat/Rainbow.git", .exact("3.1.5")),
    ],
    targets: [
        .target(name: "SwagGen", dependencies: [
          "SwagGenKit",
          "SwiftCLI",
          "Rainbow",
          "PathKit",
        ]),
        .target(name: "SwagGenKit", dependencies: [
          "Swagger",
          "JSONUtilities",
          "PathKit",
          "Stencil",
        ]),
        .target(name: "Swagger", dependencies: [
          "JSONUtilities",
          "Yams",
          "PathKit",
        ]),
        .testTarget(name: "SwagGenKitTests", dependencies: [
          "SwagGenKit",
        ]),
        .testTarget(name: "SwaggerTests", dependencies: [
          "Swagger",
          "Spectre",
        ]),
    ]
)
