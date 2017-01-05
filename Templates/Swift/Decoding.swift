import JSONUtilities

struct JSONDecoder {

    static func decode<T: JSONRawType>(json: Any) throws -> T {
        guard let value = json as? T else { throw JSONUtilsError.fileNotAJSONDictionary }
        return value
    }

    static func decode<T: JSONDecodable>(json: Any) throws -> T {
        guard let jsonDictionary = json as? JSONDictionary else { throw JSONUtilsError.fileNotAJSONDictionary }
        return try T(jsonDictionary: jsonDictionary)
    }

    static func decode<T: JSONRawType>(json: Any) throws -> [T] {
        guard let array = json as? [T] else { throw JSONUtilsError.fileNotAJSONDictionary }
        return array
    }

    static func decode<T: JSONDecodable>(json: Any) throws -> [T] {
        guard let array = json as? [JSONDictionary] else { throw JSONUtilsError.fileNotAJSONDictionary }
        return try array.map(T.init)
    }

    static func decode<T: JSONRawType>(json: Any) throws -> [String: T] {
        guard let jsonDictionary = json as? JSONDictionary else { throw JSONUtilsError.fileNotAJSONDictionary }
        var dictionary: [String: T] = [:]
        for (key, value) in jsonDictionary {
            dictionary[key] = try jsonDictionary.json(atKeyPath: key)
        }
        return dictionary
    }

    static func decode<T: JSONDecodable>(json: Any) throws -> [String: T] {
        guard let jsonDictionary = json as? JSONDictionary else { throw JSONUtilsError.fileNotAJSONDictionary }
        var dictionary: [String: T] = [:]
        for (key, value) in jsonDictionary {
            dictionary[key] = try jsonDictionary.json(atKeyPath: key)
        }
        return dictionary
    }

    static func decode<T: JSONPrimitiveConvertible>(json: Any) throws -> [String: T] {
        guard let jsonDictionary = json as? JSONDictionary else { throw JSONUtilsError.fileNotAJSONDictionary }
        var dictionary: [String: T] = [:]
        for (key, value) in jsonDictionary {
            dictionary[key] = try jsonDictionary.json(atKeyPath: key)
        }
        return dictionary
    }
}

// Decoding

public typealias JSONDecodable = JSONObjectConvertible

let dateFormatters = {
    return ["yyyy-MM-dd",
    "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
    "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
    "yyyy-MM-dd'T'HH:mm:ss'Z'",
    ].map { (format: String) -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}()

extension JSONDecodable {

    public init(json: Any) throws {
        guard let jsonDictionary = json as? JSONDictionary else { throw JSONUtilsError.fileNotAJSONDictionary }
        try self.init(jsonDictionary: jsonDictionary)
    }
}

extension Date: JSONPrimitiveConvertible {

    public typealias JSONType = String

    public static func from(jsonValue: String) -> Date? {

        for formatter in dateFormatters {
            if let date = formatter.date(from: jsonValue) {
                return self.init(timeIntervalSince1970: date.timeIntervalSince1970)
            }
        }
        return nil
    }
}


// Encoding

protocol JSONEncodable {
    func encode() -> JSONDictionary
}

protocol JSONValueEncodable {
    func encode() -> Any
}

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = {{ options.name }}.dateEncodingFormat
    return dateFormatter
}()

extension Date: JSONValueEncodable {

    func encode() -> Any {
        dateFormatter.dateFormat = {{ options.name }}.dateEncodingFormat
        return dateFormatter.string(from: self)
    }
}
