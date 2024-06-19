// Sources/CodableXPC/XPCSingleValueDecodingContainer.swift -
// SingleValueDecodingContainer for XPC
//
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// -----------------------------------------------------------------------------
//
// This file contains a SingleValueDecodingContainer implementation for
// xpc_object_t.
//
// -----------------------------------------------------------------------------//

import XPC

public struct XPCSingleValueDecodingContainer: SingleValueDecodingContainer {
    public var codingPath: [CodingKey] {
        decoder.codingPath
    }

    private let decoder: XPCDecoder
    private let underlyingMessage: xpc_object_t

    init(referencing decoder: XPCDecoder,
         wrapping xpcObject: xpc_object_t) {
        self.decoder = decoder
        self.underlyingMessage = xpcObject
    }

    public func decodeNil() -> Bool {
        underlyingMessage.decodeNil(at: codingPath)
    }

    public func decode(_ type: Bool.Type) throws -> Bool {
        try underlyingMessage.decodeBool(at: codingPath)
    }

    public func decode(_ type: String.Type) throws -> String {
        try underlyingMessage.decodeString(at: codingPath)
    }

    public func decode(_ type: Double.Type) throws -> Double {
        try underlyingMessage.decodeFloatingPointNumber(Double.self,
                                                        at: codingPath)
    }

    public func decode(_ type: Float.Type) throws -> Float {
        try underlyingMessage.decodeFloatingPointNumber(Float.self,
                                                        at: codingPath)
    }

    public func decode(_ type: Int.Type) throws -> Int {
        try underlyingMessage.decodeSignedInteger(Int.self,
                                                  at: codingPath)
    }

    public func decode(_ type: Int8.Type) throws -> Int8 {
        try underlyingMessage.decodeSignedInteger(Int8.self,
                                                  at: self.codingPath)
    }

    public func decode(_ type: Int16.Type) throws -> Int16 {
        try underlyingMessage.decodeSignedInteger(Int16.self,
                                                  at: self.codingPath)
    }

    public func decode(_ type: Int32.Type) throws -> Int32 {
        try underlyingMessage.decodeSignedInteger(Int32.self,
                                                  at: codingPath)
    }

    public func decode(_ type: Int64.Type) throws -> Int64 {
        try underlyingMessage.decodeSignedInteger(Int64.self,
                                                  at: codingPath)
    }

    public func decode(_ type: UInt.Type) throws -> UInt {
        try underlyingMessage.decodeUnsignedInteger(UInt.self,
                                                    at: codingPath)
    }

    public func decode(_ type: UInt8.Type) throws -> UInt8 {
        try underlyingMessage.decodeUnsignedInteger(UInt8.self,
                                                    at: codingPath)
    }

    public func decode(_ type: UInt16.Type) throws -> UInt16 {
        try underlyingMessage.decodeUnsignedInteger(UInt16.self,
                                                    at: codingPath)
    }

    public func decode(_ type: UInt32.Type) throws -> UInt32 {
        try self.underlyingMessage.decodeUnsignedInteger(UInt32.self,
                                                         at: codingPath)
    }

    public func decode(_ type: UInt64.Type) throws -> UInt64 {
        try self.underlyingMessage.decodeUnsignedInteger(UInt64.self,
                                                         at: codingPath)
    }

    public func decode<T: Decodable>(_ type: T.Type) throws -> T {
        try T(from: XPCDecoder(withUnderlyingMessage: underlyingMessage,
                               at: decoder.codingPath))
    }
}
