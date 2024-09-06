//
//  Encoder.swift
//  Commons
//
//  Created by Yago Marques on 30/08/24.
//

import Foundation

public final class Coder {
    public static let shared = Coder()
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    private init() { }
    
    public func encode(_ value: Encodable) throws -> Data {
        try encoder.encode(value)
    }
    
    public func decode(_ type: Decodable.Type, from data: Data) throws -> Decodable {
        try decoder.decode(type, from: data)
    }
}
