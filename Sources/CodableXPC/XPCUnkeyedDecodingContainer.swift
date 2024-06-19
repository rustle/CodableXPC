// Sources/CodableXPC/XPCUnkeyedDecodingContainer.swift -
// UnkeyedDecodingContainer for XPC
//
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// -----------------------------------------------------------------------------
//
// This file contains a UnkeyedDecodingContainer implementation for
// xpc_object_t.
//
// -----------------------------------------------------------------------------//

import XPC

public struct XPCUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    public var codingPath: [CodingKey] {
        decoder.codingPath
    }

    public var count: Int? {
        xpc_array_get_count(underlyingMessage)
    }

    public var isAtEnd: Bool {
        currentIndex >= xpc_array_get_count(underlyingMessage)
    }

    public private(set) var currentIndex: Int

    private let underlyingMessage: xpc_object_t

    private let decoder: XPCDecoder

    init(referencing decoder: XPCDecoder,
         wrapping: xpc_object_t) throws {
        guard xpc_get_type(wrapping) == XPC_TYPE_ARRAY else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath,
                                                                    debugDescription: "Did not find xpc array in unkeyed container."))
        }

        self.underlyingMessage = wrapping
        self.decoder = decoder
        self.currentIndex = 0
    }

    private mutating func decodeIntegerType<I: SignedInteger & FixedWidthInteger>(_ type: I.Type) throws -> I {
        guard !self.isAtEnd else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath,
                                                                    debugDescription: "Reached end of unkeyed container."))
        }
        decoder.codingPath.append(XPCCodingKey(intValue: currentIndex)!)
        defer { decoder.codingPath.removeLast() }

        let foundValue = xpc_array_get_value(underlyingMessage,
                                             currentIndex)

        let integer: I = try foundValue.decodeSignedInteger(type.self,
                                                            at: codingPath)
        currentIndex += 1
        return integer
    }

    private mutating func decodeIntegerType<I: UnsignedInteger & FixedWidthInteger>(_ type: I.Type) throws -> I {
        guard !self.isAtEnd else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath,
                                                                    debugDescription: "Reached end of unkeyed container."))
        }
        decoder.codingPath.append(XPCCodingKey(intValue: currentIndex)!)
        defer { decoder.codingPath.removeLast() }

        let foundValue = xpc_array_get_value(underlyingMessage,
                                             currentIndex)

        let integer: I = try foundValue.decodeUnsignedInteger(type.self,
                                                              at: codingPath)
        currentIndex += 1
        return integer
    }

    private mutating func decodeFloatingPointType<F: BinaryFloatingPoint>(_ type: F.Type) throws -> F {
        guard !self.isAtEnd else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath,
                                                                    debugDescription: "Reached end of unkeyed container."))
        }
        decoder.codingPath.append(XPCCodingKey(intValue: currentIndex)!)
        defer { decoder.codingPath.removeLast() }

        let foundValue = xpc_array_get_value(underlyingMessage,
                                             currentIndex)

        let float: F = try foundValue.decodeFloatingPointNumber(type.self,
                                                                at: codingPath)
        currentIndex += 1
        return float
    }

    // MARK: - UnkeyedDecodingContainer protocol methods

    public mutating func decodeNil() throws -> Bool {
        guard !self.isAtEnd else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath,
                                                                    debugDescription: "Reached end of unkeyed container."))
        }
        decoder.codingPath.append(XPCCodingKey(intValue: currentIndex)!)
        defer { decoder.codingPath.removeLast() }

        let foundValue = xpc_array_get_value(underlyingMessage,
                                             currentIndex)

        if foundValue.decodeNil(at: codingPath) {
            currentIndex += 1
            return true
        }
        return false
    }

    public mutating func decode(_ type: Bool.Type) throws -> Bool {
        guard !self.isAtEnd else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath,
                                                                    debugDescription: "Reached end of unkeyed container."))
        }
        decoder.codingPath.append(XPCCodingKey(intValue: currentIndex)!)
        defer { decoder.codingPath.removeLast() }

        let foundValue = xpc_array_get_value(underlyingMessage,
                                             currentIndex)

        let boolean = try foundValue.decodeBool(at: codingPath)
        currentIndex += 1
        return boolean
    }

    public mutating func decode(_ type: String.Type) throws -> String {
        guard !self.isAtEnd else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath,
                                                                    debugDescription: "Reached end of unkeyed container."))
        }
        decoder.codingPath.append(XPCCodingKey(intValue: currentIndex)!)
        defer { decoder.codingPath.removeLast() }

        let foundValue = xpc_array_get_value(underlyingMessage,
                                             currentIndex)

        let string = try foundValue.decodeString(at: codingPath)
        currentIndex += 1
        return string
    }

    public mutating func decode(_ type: Double.Type) throws -> Double {
        try decodeFloatingPointType(type)
    }

    public mutating func decode(_ type: Float.Type) throws -> Float {
        try decodeFloatingPointType(type)
    }

    public mutating func decode(_ type: Int.Type) throws -> Int {
        try decodeIntegerType(type)
    }

    public mutating func decode(_ type: Int8.Type) throws -> Int8 {
        try decodeIntegerType(type)
    }

    public mutating func decode(_ type: Int16.Type) throws -> Int16 {
        try decodeIntegerType(type)
    }

    public mutating func decode(_ type: Int32.Type) throws -> Int32 {
        try decodeIntegerType(type)
    }

    public mutating func decode(_ type: Int64.Type) throws -> Int64 {
        try decodeIntegerType(type)
    }

    public mutating func decode(_ type: UInt.Type) throws -> UInt {
        try decodeIntegerType(type)
    }

    public mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        try decodeIntegerType(type)
    }

    public mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        try decodeIntegerType(type)
    }

    public mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        try decodeIntegerType(type)
    }

    public mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        try decodeIntegerType(type)
    }

    public mutating func decode<T: Decodable>(_ type: T.Type) throws -> T {
        guard !self.isAtEnd else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath,
                                                                    debugDescription: "Reached end of unkeyed container."))
        }
        decoder.codingPath.append(XPCCodingKey(intValue: currentIndex)!)
        defer { decoder.codingPath.removeLast() }

        let foundValue = xpc_array_get_value(underlyingMessage,
                                             currentIndex)

        let constructedValue = try T(from: XPCDecoder(withUnderlyingMessage: foundValue,
                                                      at: decoder.codingPath))
        currentIndex += 1
        return constructedValue
    }

    public mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        guard !self.isAtEnd else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath,
                                                                    debugDescription: "Reached end of unkeyed container."))
        }
        decoder.codingPath.append(XPCCodingKey(intValue: currentIndex)!)
        defer { decoder.codingPath.removeLast() }

        let foundValue = xpc_array_get_value(underlyingMessage,
                                             currentIndex)

        let container = try XPCKeyedDecodingContainer<NestedKey>(referencing: decoder,
                                                                 wrapping: foundValue)
        currentIndex += 1
        return KeyedDecodingContainer(container)
    }

    public mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        guard !self.isAtEnd else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath,
                                                                    debugDescription: "Reached end of unkeyed container."))
        }
        decoder.codingPath.append(XPCCodingKey(intValue: currentIndex)!)
        defer { decoder.codingPath.removeLast() }

        let foundValue = xpc_array_get_value(underlyingMessage,
                                             currentIndex)

        let container = try XPCUnkeyedDecodingContainer(referencing: self.decoder, wrapping: foundValue)
        self.currentIndex += 1
        return container
    }

    public mutating func superDecoder() throws -> Decoder {
        guard !self.isAtEnd else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath,
                                                                    debugDescription: "Reached end of unkeyed container."))
        }
        decoder.codingPath.append(XPCCodingKey(intValue: currentIndex)!)
        defer { decoder.codingPath.removeLast() }

        let foundValue = xpc_array_get_value(underlyingMessage,
                                             currentIndex)
        currentIndex += 1
        return XPCDecoder(withUnderlyingMessage: foundValue,
                          at: decoder.codingPath)
    }
}
