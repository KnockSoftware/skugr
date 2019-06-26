// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "skugr",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.1.0"),

//        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
//
//        // A job system for Swift backends
        .package(url: "https://github.com/BrettRToomey/Jobs.git", from: "1.1.1"),
//
//        // Location-related APIs intended to be used by server-side Swift applications since there is no CoreLocation on Linux.
        .package(url: "https://github.com/petrpavlik/GeoSwift.git", from: "1.0.5"),
//
//        // 👮 Vapor 3 based API Guardian Middleware
        .package(url: "https://github.com/KnockSoftware/Guardian.git", from: "3.0.3")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "FluentSQLite", "Jobs", "GeoSwift", "Guardian"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

