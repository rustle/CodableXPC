// Sources/CodableXPC/XPCCodingKey.swift - CodingKey Implementation for XPC
//
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// -----------------------------------------------------------------------------
//
// This file degines a coding key specific for supporting XPC. This mainly used
// for the super key.
//
// -----------------------------------------------------------------------------

import XPC

public struct XPCCodingKey: CodingKey {
    static let superKey = XPCCodingKey(intValue: 0,
                                       stringValue: "super")

    public let stringValue: String

    public init?(stringValue: String) {
        intValue = nil
        self.stringValue = stringValue
    }

    public let intValue: Int?

    public init?(intValue: Int) {
        self.intValue = intValue
        stringValue = String(intValue)
    }

    public init(intValue: Int,
                stringValue: String) {
        self.intValue = intValue
        self.stringValue = stringValue
    }
}
