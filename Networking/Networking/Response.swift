//
//  Response.swift
//  Networking
//
//  Created by Yago Marques on 30/08/24.
//

import Foundation

public enum ResponseStatus: Equatable {
    case finished
    case stoped(reason: String)
}

public struct Response {
    public let code: Int?
    public let data: Data?
    public let status: ResponseStatus
    
    public init(code: Int?, data: Data?, status: ResponseStatus) {
        self.code = code
        self.data = data
        self.status = status
    }
    
    static func stoped(reason: String) -> Self {
        .init(code: nil, data: nil, status: .stoped(reason: reason))
    }
    
    static func finished(code: Int, data: Data) -> Self {
        .init(code: code, data: data, status: .finished)
    }
}
