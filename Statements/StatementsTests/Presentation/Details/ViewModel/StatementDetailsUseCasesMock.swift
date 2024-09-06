//
//  StatementDetailsUseCasesMock.swift
//  StatementsTests
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation
import Statements

struct StatementDetailsUseCasesMockError: Error { }

final class StatementDetailsUseCasesMock: StatementDetailsViewModelUseCases {
    var shouldCompletionFailure = false
    
    func executeFetchStatementDetails(with id: String, completionHandler: @escaping (Result<BusinessStatementDetails, Error>) -> Void) {
        if shouldCompletionFailure {
            completionHandler(.failure(StatementDetailsUseCasesMockError()))
        } else {
            completionHandler(.success(.init(
                description: "description",
                label: "label",
                amount: "amount",
                dateEvent: "date",
                recipient: .init(
                    bankName: "name",
                    documentType: .cpf,
                    documentNumber: "ff",
                    accountNumber: "dd",
                    agencyNumber: "",
                    name: ""
                ),
                sender: .init(
                    bankName: "name",
                    documentType: .cpf,
                    documentNumber: "ff",
                    accountNumber: "dd",
                    agencyNumber: "",
                    name: ""
                )
            )))
        }
    }
}
