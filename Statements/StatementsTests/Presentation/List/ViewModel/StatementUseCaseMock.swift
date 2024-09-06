//
//  StatementUseCaseMock.swift
//  StatementsTests
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation
import Statements

struct StatementUseCaseMockError: Error {}

final class StatementUseCaseMock: StatementViewModelUseCases {
    var shouldThrowError = false
    let mockedResponse: BusinessStatementsGroup = .init(
        group: [
            .init(
                statements: [
                    .init(
                        id: "id",
                        description: "description",
                        label: "label",
                        type: .credit,
                        amount: "R$ 100,00",
                        name: "name",
                        dateEvent: "10 de agosto",
                        status: "completed"
                    )
                ],
                date: "04/04/2024"
            )
        ]
    )
    
    func executeFetchStatements() async throws -> BusinessStatementsGroup {
        if shouldThrowError {
            throw StatementUseCaseMockError()
        } else {
            return mockedResponse
        }
    }
}
