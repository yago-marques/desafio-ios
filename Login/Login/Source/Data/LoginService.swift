//
//  LoginService.swift
//  Login
//
//  Created by Yago Marques on 30/08/24.
//

import Foundation
import Networking
import Commons

public enum LoginServiceError: Error {
    case invalidStatusCode
    case invalidLoginResponse
    case emptyData
}

public final class LoginService {
    private let httpClient: HTTPClient
    
    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
}

extension LoginService: LoginAuthUseCase {
    public func executeLoginAuth(with request: LoginRequest) async throws -> LoginResponse {
        let response = try await httpClient.executeHTTP(endpoint: LoginEndpoint.auth(request))
        
        if response.code != 200 {
            throw LoginServiceError.invalidStatusCode
        }
        
        if let data = response.data {
            if let loginResponse = try Coder.shared.decode(LoginResponse.self, from: data) as? LoginResponse {
                return loginResponse
            } else {
                throw LoginServiceError.invalidLoginResponse
            }
        } else {
            throw LoginServiceError.emptyData
        }
    }
}
