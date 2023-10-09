import PackageDescription

let package = Package(
    name: "Example",
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", 
        .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(name: "Library"),
        .target(name: "AnotherLibrary", dependencies: ["Library"]),
        .target(name: "Library", dependencies: ["RxSwift"])
    ]
)
