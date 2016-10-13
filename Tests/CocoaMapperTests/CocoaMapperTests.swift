import XCTest
@testable import CocoaMapper
import Mapper

struct Nest1 {
    let string: String
    enum Keys : String, IndexPathElement {
        case string
    }
}

extension Nest1 : Mappable {
    init<Source : InMap>(mapper: InMapper<Source, Keys>) throws {
        self.string = try mapper.map(from: .string)
    }
    func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, Nest1.Keys>) throws {
        try mapper.map(self.string, to: .string)
    }
}

enum EnumNest : String {
    case alba, lange
}

struct Test1 {
    let int: Int
    let string: String
    let bool: Bool
    let double: Double
    let ints: [Int]
    let strings: [String]
    let bools: [Bool]
    let doubles: [Double]
    let nest: Nest1
    let nests: [Nest1]
    let enumNest: EnumNest
    let enumNests: [EnumNest]
    
    enum Keys : String, IndexPathElement {
        case int, string, bool, double, ints, strings, bools, doubles, nest, nests, enumNest, enumNests
    }
}

extension Test1 : Mappable {
    init<Source : InMap>(mapper: InMapper<Source, Keys>) throws {
        self.int = try mapper.map(from: .int)
        self.string = try mapper.map(from: .string)
        self.bool = try mapper.map(from: .bool)
        self.double = try mapper.map(from: .double)
        self.ints = try mapper.map(from: .ints)
        self.strings = try mapper.map(from: .strings)
        self.bools = try mapper.map(from: .bools)
        self.doubles = try mapper.map(from: .doubles)
        self.nest = try mapper.map(from: .nest)
        self.nests = try mapper.map(from: .nests)
        self.enumNest = try mapper.map(from: .enumNest)
        self.enumNests = try mapper.map(from: .enumNests)
    }
    func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, Test1.Keys>) throws {
        try mapper.map(self.int, to: .int)
        try mapper.map(self.string, to: .string)
        try mapper.map(self.bool, to: .bool)
        try mapper.map(self.double, to: .double)
        try mapper.map(self.ints, to: .ints)
        try mapper.map(self.strings, to: .strings)
        try mapper.map(self.bools, to: .bools)
        try mapper.map(self.doubles, to: .doubles)
        try mapper.map(self.nest, to: .nest)
        try mapper.map(self.nests, to: .nests)
        try mapper.map(self.enumNest, to: .enumNest)
        try mapper.map(self.enumNests, to: .enumNests)
    }
}

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

class CocoaMapperTests: XCTestCase {
    
    func testCocoaMapper() throws {
        let test1 = Test1(int: 5,
                          string: "Flo",
                          bool: true,
                          double: 7.0,
                          ints: [1, 2, 3, 4, 5, -1],
                          strings: ["Pages", "Of", "Gold"],
                          bools: [false, true, false],
                          doubles: [1.0, 2.0, -1.5],
                          nest: .init(string: "Tomorrow Will Be"),
                          nests: ["Secret", "Gold"].map(Nest1.init),
                          enumNest: .alba,
                          enumNests: [.alba, .lange])
        let cocoaDict: [String: Any] = try test1.map()
        let backTest = try Test1(from: cocoaDict)
        XCTAssertEqual(backTest.int, test1.int)
        XCTAssertEqual(backTest.string, test1.string)
        XCTAssertEqual(backTest.double, test1.double)
        XCTAssertEqual(backTest.bool, test1.bool)
        XCTAssertEqual(backTest.ints, test1.ints)
        XCTAssertEqual(backTest.strings, test1.strings)
        XCTAssertEqual(backTest.doubles, test1.doubles)
        XCTAssertEqual(backTest.bools, test1.bools)
        XCTAssertEqual(backTest.nest.string, test1.nest.string)
        XCTAssertEqual(backTest.nests.map({ $0.string }), test1.nests.map({ $0.string }))
        XCTAssertEqual(backTest.enumNest, test1.enumNest)
        XCTAssertEqual(backTest.enumNests, test1.enumNests)
        dump(backTest)
    }
    
    func testBatmanMovie() throws {
        let dict: [String: Any] = [
            "year": 2008,
            "title": "The Dark Knight"
        ]
        let theDarkKnightMovie = try BatmanMovie(from: dict)
        let tdkDict: [String: Any] = try theDarkKnightMovie.map()
        print(tdkDict)
    }

//    static var allTests : [(String, (CocoaMapperTests) -> () throws -> Void)] {
//        return [
//            ("testExample", testExample),
//        ]
//    }
    
}
