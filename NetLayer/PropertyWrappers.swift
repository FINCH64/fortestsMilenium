//
//  PropertyWrappers.swift
//
//
//  Created by Uladzislau on 24.07.24.
//

public protocol RawValueEnum: Codable, Equatable {
    associatedtype RawValueType: Codable

    init(rawValue: RawValueType)
    var rawValue: RawValueType { get }
}

@propertyWrapper
public struct EnumFromRawValue<EnumType: RawValueEnum>: Codable, Equatable {

    public var wrappedValue: EnumType

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(EnumType.RawValueType.self)

        wrappedValue = EnumType(rawValue: rawValue)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue.rawValue)
    }

    public init(wrappedValue: EnumType) {
        self.wrappedValue = wrappedValue
    }
}

