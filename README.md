# CocoaMapper

[![Swift][swift-badge]][swift-url]
[![Zewo][zewo-badge]][zewo-url]
[![Mapper][mapper-compatible-badge]][mapper-url]
[![Platform][platform-badge]][platform-url]
[![License][mit-badge]][mit-url]

CocoaMapper is a [**Mapper**][mapper-url]-compatible library which allows you to map your instances from/to `[String: Any]` dictionaries.

## Usage

```swift
struct BatmanMovie {
    let rating: Int
    let title: String
    let releaseDate: Date
    
    enum MappingKeys : String, IndexPathElement {
        case rating, title, releaseDate
    }
}

extension BatmanMovie : InMappable {
    init<Source : InMap>(mapper: InMapper<Source, MappingKeys>) throws {
        self.rating = try mapper.map(from: .rating)
        self.title = try mapper.map(from: .title)
        self.releaseDate = try mapper.unsafe_map(from: .releaseDate)
    }
}

extension BatmanMovie : OutMappable {
    func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, MappingKeys>) throws {
        try mapper.map(self.rating, to: .rating)
        try mapper.map(self.title, to: .title)
        try mapper.unsafe_map(self.releaseDate, to: .releaseDate)
    }
}

let dict: [String: Any] = [
    "rating": 4,
    "title": "The Dark Knight",
    "releaseDate": Date(),
]
let theDarkKnightMovie = try BatmanMovie(from: dict)
let tdkDict: [String: Any] = try theDarkKnightMovie.map()

```

## Note on "Plist date types"

`[String: Any]` is widely used in a lot of different places in Cocoa API. Remember that if you're using it as a "plist dictionary", you can safely put `Date` (ex-`NSDate`) and `Data` (ex-`NSData`) in it using `unsafe_map`/`unsafe_mapArray` functions.

[swift-badge]: https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat
[swift-url]: https://swift.org
[zewo-badge]: https://img.shields.io/badge/Zewo-0.14-FF7565.svg?style=flat
[zewo-url]: http://zewo.io
[mapper-compatible-badge]: https://img.shields.io/badge/Mapper-0.14-yellow.svg
[mapper-url]: https://github.com/Zewo/Mapper
[platform-badge]: https://img.shields.io/badge/Platforms-OS%20X%20--%20Linux-lightgray.svg?style=flat
[platform-url]: https://swift.org
[mit-badge]: https://img.shields.io/badge/License-MIT-blue.svg?style=flat
[mit-url]: https://tldrlegal.com/license/mit-license