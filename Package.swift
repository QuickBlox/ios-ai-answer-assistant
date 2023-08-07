// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QBAIAnswerAssistant",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "QBAIAnswerAssistant",
            targets: ["QBAIAnswerAssistant"]),
    ],
    targets: [
        .target(
            name: "QBAIAnswerAssistant"),
        .testTarget(
            name: "QBAIAnswerAssistantTests",
            dependencies: ["QBAIAnswerAssistant"]),
        .testTarget(name: "QBAIAnswerAssistantIntegrationTests",
                    dependencies: ["QBAIAnswerAssistant"]),
    ]
)
