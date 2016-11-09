import PackageDescription

let package = Package(
    name: "CocoaMapper",
    dependencies: [
        .Package(url: "https://github.com/Zewo/Mapper", majorVersion: 0, minor: 14),
    ]
)
