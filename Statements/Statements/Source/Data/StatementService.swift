//
//  StatementService.swift
//  Statements
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation
import Networking
import Commons

enum StatementServiceError: Error {
    case invalidResponse
}

public final class StatementService {
    private let httpClient: HTTPClient
    
    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
}

extension StatementService: FetchStatementsUseCase {
    public func executeFetchStatements() async throws -> BusinessStatementsGroup {
        let response = try await httpClient.executeHTTP(endpoint: StatementEndpoint.fetchStatements)
        guard
            let data = response.data,
            let remoteStatements = try? Coder.shared.decode(RemoteStatementsGroup.self, from: data) as? RemoteStatementsGroup
        else {
            throw StatementServiceError.invalidResponse
        }
        
        return StatementsMapper.shared.toBusiness(from: remoteStatements)
    }
}


extension StatementService: FetchStatementDetailsUseCase {
    public func executeFetchStatementDetails(with id: String, completionHandler: @escaping (Result<BusinessStatementDetails, Error>) -> Void) {
        httpClient.executeHTTP(endpoint: StatementEndpoint.fetchStatementDetails(id: id)) { result in
            switch result {
            case .success(let response):
                guard
                    let data = response.data,
                    let remoteStatementDetail = try? Coder.shared.decode(RemoteStatementDetails.self, from: data) as? RemoteStatementDetails
                else {
                    completionHandler(.failure(StatementServiceError.invalidResponse))
                    return
                }
                
                let businessModel = StatementDetailsMapper.shared.toBusiness(from: remoteStatementDetail)
                completionHandler(.success(businessModel))
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
    }
}
