//
//  RefreshToken.swift
//  Networking
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation
import Storage
import Commons

enum RefreshTokenServiceError: Error {
    case invalidResponse
}

final class RefreshTokenService {
    static let shared = RefreshTokenService()
    private let httpClient = Network()
    
    private init() {}
    
    public func generate() async throws -> String? {
        guard let token = Keychain.shared.getItem(for: .token) as? String else { return nil }
        let payload = RefreshTokenPayload(token: token)
        let response = try await httpClient.executeHTTP(endpoint: RefreshTokenEndpoint.generate(payload))
        if
            let code = response.code,
            code == 200,
            let data = response.data,
            let responsePayload = try? Coder.shared.decode(RefreshTokenPayload.self, from: data) as? RefreshTokenPayload
        {
            Keychain.shared.setItem(responsePayload.token, for: .token)
            Keychain.shared.setItem(Date(), for: .tokenDate)
            return responsePayload.token
        } else {
            throw RefreshTokenServiceError.invalidResponse
        }
    }
    
    public func generate(completion: @escaping (Result<String?, Error>) -> Void) {
        guard let token = Keychain.shared.getItem(for: .token) as? String else {
            completion(.success(nil))
            return
        }
        
        let payload = RefreshTokenPayload(token: token)
        
        httpClient.executeHTTP(endpoint: RefreshTokenEndpoint.generate(payload)) { result in
            switch result {
            case .success(let response):
                if
                    let code = response.code,
                    code == 200,
                    let data = response.data,
                    let responsePayload = try? Coder.shared.decode(RefreshTokenPayload.self, from: data) as? RefreshTokenPayload
                {
                    Keychain.shared.setItem(responsePayload.token, for: .token)
                    Keychain.shared.setItem(Date(), for: .tokenDate)
                    completion(.success(responsePayload.token))
                } else {
                    completion(.failure(RefreshTokenServiceError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
