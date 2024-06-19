// Sources/CodableXPC/XPCKeyedEncodingContainer.swift - KeyedEncodingContainer
// implementation for XPC
//
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// -----------------------------------------------------------------------------
//
// This file contains a KeyedEncodingContainer implementation for xpc_object_t.
// This includes a specialization of the XPCEncoder for handling the super
// class case, as we don't know what container type is going to be needed to
// handle it.
//
// -----------------------------------------------------------------------------//
 import XPC

public struct XPCKeyedEncodingContainer<K: CodingKey>: KeyedEncodingContainerProtocol {
    public typealias Key = K

    /// A reference to the encoder we're writing to.
    private let encoder: XPCEncoder

    private let underlyingMesage: xpc_object_t

    /// The path of coding keys taken to get to this point in encoding.
    public var codingPath: [CodingKey] {
        encoder.codingPath
    }

    /// Initializes `self` with the given references.
    init(referencing encoder: XPCEncoder,
         wrapping dictionary: xpc_object_t) throws {
        self.encoder = encoder
        guard xpc_get_type(dictionary) == XPC_TYPE_DICTIONARY else {
            throw XPCEncodingHelpers.makeEncodingError(dictionary,
                                                       encoder.codingPath,
                                                       "Internal error")
        }
        underlyingMesage = dictionary
    }

    // MARK: - KeyedEncodingContainerProtocol Methods

    public mutating func encodeNil(forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeNil()) })
    }

    public mutating func encode(_ value: Bool,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_bool(underlyingMesage,
                                                              $0,
                                                              value) })
    }

    public mutating func encode(_ value: Int,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeSignedInteger(value)) })
    }

    public mutating func encode(_ value: Int8,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeSignedInteger(value)) })
    }

    public mutating func encode(_ value: Int16,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeSignedInteger(value)) })
    }

    public mutating func encode(_ value: Int32,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeSignedInteger(value)) })
    }

    public mutating func encode(_ value: Int64,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeSignedInteger(value)) })
    }

    public mutating func encode(_ value: UInt,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeUnsignedInteger(value)) })
    }

    public mutating func encode(_ value: UInt8,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeUnsignedInteger(value)) })
    }

    public mutating func encode(_ value: UInt16,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeUnsignedInteger(value)) })
    }

    public mutating func encode(_ value: UInt32,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeUnsignedInteger(value)) })
    }

    public mutating func encode(_ value: UInt64,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeUnsignedInteger(value)) })
    }

    public mutating func encode(_ value: String,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeString(value)) })
    }

    public mutating func encode(_ value: Float,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeFloat(value)) })
    }

    public mutating func encode(_ value: Double,
                                forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               XPCEncodingHelpers.encodeDouble(value)) })
    }

    public mutating func encode<T: Encodable>(_ value: T, forKey key: Key) throws {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        do {
            let xpcObject = try XPCEncoder.encode(value,
                                                  at: encoder.codingPath)
            key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                                   $0,
                                                                   xpcObject) })
        } catch let error as EncodingError {
            throw error
        } catch {
            throw XPCEncodingHelpers.makeEncodingError(value,
                                                       codingPath,
                                                       String(describing: error))
        }
    }

    public mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        let xpcDictionary = xpc_dictionary_create(nil,
                                                  nil,
                                                  0)
        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               xpcDictionary) })
        // It is OK to force this through because we know we are providing a dictionary
        let container = try! XPCKeyedEncodingContainer<NestedKey>(referencing: encoder,
                                                                  wrapping: xpcDictionary)
        return KeyedEncodingContainer(container)
    }

    public mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        let xpcArray = xpc_array_create(nil,
                                        0)
        key.stringValue.withCString({ xpc_dictionary_set_value(underlyingMesage,
                                                               $0,
                                                               xpcArray) })
        let container = try! XPCUnkeyedEncodingContainer(referencing: encoder,
                                                         wrapping: xpcArray)
        return container
    }

    public mutating func superEncoder() -> Encoder {
        encoder.codingPath.append(XPCCodingKey.superKey)
        defer { encoder.codingPath.removeLast() }

        return XPCDictionaryReferencingEncoder(at: encoder.codingPath,
                                               wrapping: underlyingMesage,
                                               forKey: XPCCodingKey.superKey)
    }

    public mutating func superEncoder(forKey key: Key) -> Encoder {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }

        return XPCDictionaryReferencingEncoder(at: encoder.codingPath,
                                               wrapping: underlyingMesage,
                                               forKey: key)
    }
}

// This is used for encoding super classes, we don't know yet what kind of
// container the caller will request so we can not prepopulate in superEncoder().
// To overcome this we alias the encoder, the underlying dictionary, and the key
// to use, this way we can insert the key-value pair upon request and use the
// encoder to maintain the encoding state
fileprivate class XPCDictionaryReferencingEncoder: XPCEncoder {
    let xpcDictionary: xpc_object_t
    let key: CodingKey

    init(at codingPath: [CodingKey],
         wrapping dictionary: xpc_object_t,
         forKey key: CodingKey) {
        self.xpcDictionary = dictionary
        self.key = key
        super.init(at: codingPath)
    }

    override func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        let newDictionary = xpc_dictionary_create(nil,
                                                  nil,
                                                  0)
        self.key.stringValue.withCString({ xpc_dictionary_set_value(xpcDictionary,
                                                                    $0,
                                                                    newDictionary) })

        // It is OK to force this through because we are explicitly passing a dictionary
        let container = try! XPCKeyedEncodingContainer<Key>(referencing: self,
                                                            wrapping: newDictionary)
        return KeyedEncodingContainer(container)
    }

    override func unkeyedContainer() -> UnkeyedEncodingContainer {
        let newArray = xpc_array_create(nil,
                                        0)
        key.stringValue.withCString({ xpc_dictionary_set_value(xpcDictionary,
                                                               $0,
                                                               newArray) })

        // It is OK to force this through because we are explicitly passing an array
        return try! XPCUnkeyedEncodingContainer(referencing: self,
                                                wrapping: newArray)
    }

    override func singleValueContainer() -> SingleValueEncodingContainer {
        // It is OK to force this through because we are explicitly passing a dictionary
        return XPCSingleValueEncodingContainer(referencing: self, insertionClosure: { value in
            self.key.stringValue.withCString({ xpc_dictionary_set_value(self.xpcDictionary,
                                                                        $0,
                                                                        value) })
        })
    }
}
