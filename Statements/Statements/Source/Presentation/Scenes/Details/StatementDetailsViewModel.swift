//
//  StatementDetailsViewModel.swift
//  Statements
//
//  Created by Yago Marques on 02/09/24.
//

import Foundation

public typealias StatementDetailsViewModelUseCases = FetchStatementDetailsUseCase

public protocol StatementDetailsViewModeling {
    func fetchDetails()
}

public final class StatementDetailsViewModel: StatementDetailsViewModeling {
    
    private let statementID: String
    private let useCases: StatementDetailsViewModelUseCases
    public weak var viewController: StatementDetailsViewControllerDisplay?
    
    public init(useCases: StatementDetailsViewModelUseCases, statementID: String) {
        self.useCases = useCases
        self.statementID = statementID
    }
    
    public func fetchDetails() {
        viewController?.showSkeleton()
        useCases
            .executeFetchStatementDetails(with: statementID) { result in
                switch result {
                case .success(let details):
                    self.viewController?.configure(with: details)
                    self.viewController?.hideSkeleton()
                case .failure(_):
                    self.viewController?.hideSkeleton()
                    self.viewController?.showErrorAlert()
                }
            }
    }
    
}
