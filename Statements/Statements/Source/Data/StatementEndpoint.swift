//
//  StatementEndpoint.swift
//  Statements
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation
import Networking
import EnvironmentHelper

public enum StatementEndpoint: Endpoint {
    case fetchStatements
    case fetchStatementDetails(id: String)
    
    public var baseUrl: String {
        "https://\(EnvironmentHelper.shared.fetch(for: .coraBaseURL) ?? "")"
    }
    
    public var path: String {
        switch self {
        case .fetchStatements:
            "/challenge/list"
        case .fetchStatementDetails(let id):
            "/challenge/details/\(id)"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchStatements, .fetchStatementDetails:
            .GET
        }
    }
    
    public var queries: [String : String] {
        [:]
    }
    
    public var headers: [String : String] {
        ["apikey": EnvironmentHelper.shared.fetch(for: .coraApiKey) ?? ""]
    }
    
    public var body: Data? {
        nil
    }
    
    public var tokenNeeded: Bool {
        true
    }
}
