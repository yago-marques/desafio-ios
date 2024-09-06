//
//  LoginEndpoint.swift
//  Login
//
//  Created by Yago Marques on 30/08/24.
//

import Foundation
import Networking
import EnvironmentHelper
import Commons

public enum LoginEndpoint: Endpoint {
    case auth(LoginRequest)
    
    public var baseUrl: String {
        "https://\(EnvironmentHelper.shared.fetch(for: .coraBaseURL) ?? "")"
    }
    
    public var path: String {
        switch self {
        case .auth:
            "/challenge/auth"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .auth:
            .POST
        }
    }
    
    public var queries: [String : String] {
        [:]
    }
    
    public var headers: [String : String] {
        switch self {
        case .auth:
            ["apikey": EnvironmentHelper.shared.fetch(for: .coraApiKey) ?? ""]
        }
    }
    
    public var body: Data? {
        switch self {
        case .auth(let loginRequest):
            try? Coder.shared.encode(loginRequest)
        }
    }
    
    public var tokenNeeded: Bool {
        false
    }
}
