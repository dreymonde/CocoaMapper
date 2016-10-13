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
    let year: Int
    let title: String
    
    enum Keys : String, IndexPathElement {
        case year, title
    }
}

extension BatmanMovie : InMappable {
    init<Source : InMap>(mapper: InMapper<Source, Keys>) throws {
        self.year = try mapper.map(from: .year)
        self.title = try mapper.map(from: .title)
    }
}

extension BatmanMovie : OutMappable {
    func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, BatmanMovie.Keys>) throws {
        try mapper.map(self.year, to: .year)
        try mapper.map(self.title, to: .title)
    }
}

let dict: [String: Any] = [
    "year": 2008,
    "title": "The Dark Knight"
]
let theDarkKnightMovie = try BatmanMovie(from: dict)
let tdkDict: [String: Any] = try theDarkKnightMovie.map()

```

[swift-badge]: https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat
[swift-url]: https://swift.org
[zewo-badge]: https://img.shields.io/badge/Zewo-0.15-FF7565.svg?style=flat
[zewo-url]: http://zewo.io
[mapper-compatible-badge]: https://img.shields.io/badge/Mapper-compatible-yellow.svg
[mapper-url]: https://github.com/dreymonde/MightyMapper
[platform-badge]: https://img.shields.io/badge/Platforms-OS%20X%20--%20Linux-lightgray.svg?style=flat
[platform-url]: https://swift.org
[mit-badge]: https://img.shields.io/badge/License-MIT-blue.svg?style=flat
[mit-url]: https://tldrlegal.com/license/mit-license