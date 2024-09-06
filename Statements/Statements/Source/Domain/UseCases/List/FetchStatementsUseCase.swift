//
//  FetchStatementsUseCase.swift
//  Statements
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation

public protocol FetchStatementsUseCase {
    func executeFetchStatements() async throws -> BusinessStatementsGroup
}
