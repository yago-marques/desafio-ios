//
//  RefreshTokenEndpoint.swift
//  Networking
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation
import EnvironmentHelper
import Commons

enum RefreshTokenEndpoint: Endpoint {
    case generate(RefreshTokenPayload)
    
    var baseUrl: String {
        "https://\(EnvironmentHelper.shared.fetch(for: .coraBaseURL) ?? "")"
    }
    
    var path: String {
        "/challenge/auth"
    }
    
    var method: HTTPMethod {
        .POST
    }
    
    var queries: [String : String] {
        [:]
    }
    
    var headers: [String : String] {
        ["apikey": EnvironmentHelper.shared.fetch(for: .coraApiKey) ?? ""]
    }
    
    var body: Data? {
        switch self {
        case .generate(let refreshTokenPayload):
            try? Coder.shared.encode(refreshTokenPayload)
        }
    }
    
    var tokenNeeded: Bool {
        false
    }
}
