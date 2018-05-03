//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public class ReadOnlyFirst: Codable {

    public var bar: String?

    public var baz: String?

    public init(bar: String? = nil, baz: String? = nil) {
        self.bar = bar
        self.baz = baz
    }

    private enum CodingKeys: String, CodingKey {
        case bar
        case baz
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        bar = try container.decodeIfPresent(.bar)
        baz = try container.decodeIfPresent(.baz)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(bar, forKey: .bar)
        try container.encode(baz, forKey: .baz)
    }
}