// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let fixturesModel = try? JSONDecoder().decode(FixturesModel.self, from: jsonData)

import Foundation

// MARK: - FixturesModel
struct FixturesModel: Codable {
    let fixturesModelGet: String
    let parameters: Parameters
    let errors: [JSONAny]
    let results: Int
    let paging: Paging
    let response: [Response]

    enum CodingKeys: String, CodingKey {
        case fixturesModelGet = "get"
        case parameters, errors, results, paging, response
    }
}




// MARK: - Paging
struct Paging: Codable {
    let current, total: Int
}

// MARK: - Parameters
struct Parameters: Codable {
    let league, season: String
}

// MARK: - Response
struct Response: Codable {
    let fixture: Fixture
    let league: League
    let teams, goals: Goals
    let score: Score
}

// MARK: - Fixture
struct Fixture: Codable {
    let id: Int
    let referee: String?
    let timezone: Timezone
    let date: Date
    let timestamp: Int
    let periods: Periods
    let venue: Venue
    let status: Status
}

// MARK: - Periods
struct Periods: Codable {
    let first, second: Int?
}

// MARK: - Status
struct Status: Codable {
    let long: Long
    let short: Short
    let elapsed: Int?
}

enum Long: String, Codable {
    case matchCancelled = "Match Cancelled"
    case matchFinished = "Match Finished"
    case matchPostponed = "Match Postponed"
    case notStarted = "Not Started"
    case timeToBeDefined = "Time to be defined"
}

enum Short: String, Codable {
    case canc = "CANC"
    case ft = "FT"
    case ns = "NS"
    case pst = "PST"
    case tbd = "TBD"
}

enum Timezone: String, Codable {
    case utc = "UTC"
}

// MARK: - Venue
struct Venue: Codable {
    let id: Int
    let name: VenueName
    let city: City
}

enum City: String, Codable {
    case aktobe = "Aktobe"
    case almaty = "Almaty"
    case atyrau = "Atyrau"
    case karaganda = "Karaganda"
    case kostanay = "Kostanay"
    case kyzylorda = "Kyzylorda"
    case pavlodar = "Pavlodar"
    case petropavlosvk = "Petropavlosvk"
    case semipalatinsk = "Semipalatinsk"
    case shymkent = "Shymkent"
    case taldykorgan = "Taldykorgan"
}

enum VenueName: String, Codable {
    case ortalyqStadıon = "Ortalyq stadıon"
    case ortalyqStadıonJetisu = "Ortalyq stadıon Jetisu"
    case sportivnyyKompleksKaznu = "Sportivnyy Kompleks Kaznu"
    case stadionIMGanyMuratbaeva = "Stadion im. Gany Muratbaeva"
    case stadionJasQyran = "Stadion Jas Qyran"
    case stadionKarasay = "Stadion Karasay"
    case stadionMunayşı = "Stadion Munayşı"
    case stadionODYuShORNo8 = "Stadion ODYuShOR No. 8"
    case stadionQajimuqanMuñaytpasov = "Stadion Qajimuqan Muñaytpasov"
    case stadionShakhter = "Stadion Shakhter"
    case stadionSpartak = "Stadion Spartak"
    case tobylArena = "Tobyl Arena"
}

// MARK: - Goals
struct Goals: Codable {
    let home, away: AwayUnion
}

enum AwayUnion: Codable {
    case awayClass(AwayClass)
    case integer(Int)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(AwayClass.self) {
            self = .awayClass(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(AwayUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AwayUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .awayClass(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - AwayClass
struct AwayClass: Codable {
    let id: Int
    let name: AwayName
    let logo: String
    let winner: Bool?
}

enum AwayName: String, Codable {
    case aktobe = "Aktobe"
    case atyrau = "Atyrau"
    case fcAstana = "FC Astana"
    case fkAksu = "FK Aksu"
    case fkTobolKostanay = "FK Tobol Kostanay"
    case kairatAlmaty = "Kairat Almaty"
    case kaisar = "Kaisar"
    case kyzylZhar = "Kyzyl-Zhar"
    case ordabasy = "Ordabasy"
    case shakhterKaragandy = "Shakhter Karagandy"
    case turanTurkistan = "Turan Turkistan"
    case yelimaySemey = "Yelimay Semey"
    case zhenys = "Zhenys"
    case zhetysu = "Zhetysu"

}


// MARK: - League
struct League: Codable {
    let id: Int
    let name: LeagueName
    let country: Country
    let logo: String
    let flag: String
    let season: Int
    let round: String
}

enum Country: String, Codable {
    case kazakhstan = "Kazakhstan"
}

enum LeagueName: String, Codable {
    case premierLeague = "Premier League"
}

// MARK: - Score
struct Score: Codable {
    let halftime, fulltime, extratime, penalty: Goals
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}
