import PackageDescription

let package = Package(
    name: "CocoaMapper",
    dependencies: [
        .Package(url: "https://github.com/dreymonde/MightyMapper", majorVersion: 0, minor: 1),
    ]
)
