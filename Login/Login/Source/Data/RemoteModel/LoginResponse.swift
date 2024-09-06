//
//  LoginResponse.swift
//  Login
//
//  Created by Yago Marques on 30/08/24.
//

import Foundation

public struct LoginResponse: Decodable {
    public let token: String
    
    public init(token: String) {
        self.token = token
    }
}
