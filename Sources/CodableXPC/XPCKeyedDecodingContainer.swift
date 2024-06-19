// Sources/CodableXPC/XPCKeyedDecodingContainer.swift - KeyedDecodingContainer
// implementation for XPC
//
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// -----------------------------------------------------------------------------
//
// This file contains a KeyedDecodingContainer implementation for xpc_object_t.
//
// -----------------------------------------------------------------------------//

import XPC

public struct XPCKeyedDecodingContainer<K: CodingKey>: KeyedDecodingContainerProtocol {
    public typealias Key = K

    /// A reference to the decoder we're reading from.
    private let decoder: XPCDecoder

    /// The path of coding keys taken to get to this point in decoding.
    public var codingPath: [CodingKey] {
        decoder.codingPath
    }

    private let underlyingMessage: xpc_object_t

    /// Initializes `self` by referencing the given decoder and container.
    init(referencing decoder: XPCDecoder,
         wrapping underlyingMessage: xpc_object_t) throws {
        guard xpc_get_type(underlyingMessage) == XPC_TYPE_DICTIONARY else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath,
                                                                    debugDescription: "Did not find xpc dictionary in keyed container"))
        }
        self.decoder = decoder
        self.underlyingMessage = underlyingMessage
    }

    private func decodeIntegerType<I: SignedInteger & FixedWidthInteger>(_ type: I.Type,
                                                                         forKey key: Key) throws -> I {
        let foundValue = try getXPCObject(for: key)

        return try foundValue.decodeSignedInteger(type.self,
                                                  at: codingPath)
    }

    private func decodeIntegerType<I: UnsignedInteger & FixedWidthInteger>(_ type: I.Type,
                                                                           forKey key: Key) throws -> I {
        let foundValue = try getXPCObject(for: key)

        return try foundValue.decodeUnsignedInteger(type.self,
                                                    at: codingPath)
    }

    private func decodeFloatingPointType<F: BinaryFloatingPoint>(_ type: F.Type,
                                                                 forKey key: Key) throws -> F {
        let foundValue = try getXPCObject(for: key)

        return try foundValue.decodeFloatingPointNumber(type.self,
                                                        at: codingPath)
    }

    private func getXPCObject(for key: CodingKey) throws -> xpc_object_t {
        guard let foundValue = key.stringValue.withCString({ xpc_dictionary_get_value(underlyingMessage, $0) }) else {
            throw DecodingError.keyNotFound(key,
                                            DecodingError.Context(
                                              codingPath: codingPath,
                                              debugDescription: "Could not find key \(key.stringValue)"))
        }

        return foundValue
    }

    // MARK: - KeyedDecodingContainerProtocol Methods

    /// You shouldn't rely on this because this is slow
    public var allKeys: [Key] {
        var keys: [Key] = []
        xpc_dictionary_apply(underlyingMessage) { (key, _) -> Bool in
            keys.append(Key(stringValue: String(cString: key))!)
            return true
        }
        return keys
    }

    public func contains(_ key: Key) -> Bool {
        do {
            _ = try getXPCObject(for: key)
        } catch {
            return false
        }
        return true
    }

    public func decodeNil(forKey key: Key) throws -> Bool {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        let foundValue = try getXPCObject(for: key)

        return foundValue.decodeNil(at: codingPath)
    }

    public func decode(_ type: Bool.Type,
                       forKey key: Key) throws -> Bool {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        let foundValue = try getXPCObject(for: key)

        return try foundValue.decodeBool(at: codingPath)
    }

    public func decode(_ type: Int.Type,
                       forKey key: Key) throws -> Int {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        return try decodeIntegerType(type,
                                     forKey: key)
    }

    public func decode(_ type: Int8.Type,
                       forKey key: Key) throws -> Int8 {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        return try decodeIntegerType(type,
                                     forKey: key)
    }

    public func decode(_ type: Int16.Type,
                       forKey key: Key) throws -> Int16 {
        self.decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }

        return try decodeIntegerType(type, forKey: key)
    }

    public func decode(_ type: Int32.Type,
                       forKey key: Key) throws -> Int32 {
        self.decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }

        return try decodeIntegerType(type, forKey: key)
    }

    public func decode(_ type: Int64.Type,
                       forKey key: Key) throws -> Int64 {
        decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }

        return try decodeIntegerType(type, forKey: key)
    }

    public func decode(_ type: UInt.Type,
                       forKey key: Key) throws -> UInt {
        self.decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }

        return try decodeIntegerType(type, forKey: key)
    }

    public func decode(_ type: UInt8.Type,
                       forKey key: Key) throws -> UInt8 {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        return try decodeIntegerType(type,
                                     forKey: key)
    }

    public func decode(_ type: UInt16.Type,
                       forKey key: Key) throws -> UInt16 {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        return try decodeIntegerType(type,
                                     forKey: key)
    }

    public func decode(_ type: UInt32.Type,
                       forKey key: Key) throws -> UInt32 {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        return try decodeIntegerType(type,
                                     forKey: key)
    }

    public func decode(_ type: UInt64.Type,
                       forKey key: Key) throws -> UInt64 {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        return try decodeIntegerType(type,
                                     forKey: key)
    }

    public func decode(_ type: Float.Type,
                       forKey key: Key) throws -> Float {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        return try decodeFloatingPointType(type,
                                           forKey: key)
    }

    public func decode(_ type: Double.Type,
                       forKey key: Key) throws -> Double {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        return try decodeFloatingPointType(type,
                                           forKey: key)
    }

    public func decode(_ type: String.Type,
                       forKey key: Key) throws -> String {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        let foundValue = try getXPCObject(for: key)

        return try foundValue.decodeString(at: codingPath)
    }

    public func decode<T: Decodable>(_ type: T.Type,
                                     forKey key: Key) throws -> T {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        let foundValue = try getXPCObject(for: key)

        return try T(from: XPCDecoder(withUnderlyingMessage: foundValue,
                                      at: decoder.codingPath))
    }

    public func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type,
                                           forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        let foundValue = try getXPCObject(for: key)

        let container = try XPCKeyedDecodingContainer<NestedKey>(referencing: decoder,
                                                                 wrapping: foundValue)
        return KeyedDecodingContainer<NestedKey>(container)
    }

    public func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        let foundValue = try getXPCObject(for: key)

        return try XPCUnkeyedDecodingContainer(referencing: decoder,
                                               wrapping: foundValue)
    }

    public func superDecoder() throws -> Decoder {
        decoder.codingPath.append(XPCCodingKey.superKey)
        defer { decoder.codingPath.removeLast() }

        let foundValue = try getXPCObject(for: XPCCodingKey.superKey)

        return XPCDecoder(withUnderlyingMessage: foundValue,
                          at: decoder.codingPath)
    }

    public func superDecoder(forKey key: Key) throws -> Decoder {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }

        let foundValue = try getXPCObject(for: key)

        return XPCDecoder(withUnderlyingMessage: foundValue,
                          at: decoder.codingPath)
    }
}
