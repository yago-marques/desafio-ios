//
//  FetchStatementDetailsUseCase.swift
//  Statements
//
//  Created by Yago Marques on 02/09/24.
//

import Foundation

public protocol FetchStatementDetailsUseCase {
    func executeFetchStatementDetails(with id: String, completionHandler: @escaping (Result<BusinessStatementDetails, Error>) -> Void)
}
