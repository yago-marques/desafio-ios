//
//  StatementViewModel.swift
//  Statements
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation

public typealias StatementViewModelUseCases = FetchStatementsUseCase

public protocol StatementsViewModeling: AnyObject {
    var presentedStatements: BusinessStatementsGroup? { get }
    func fetchStatements() async
    func refreshStatements() async
    func filterStatements(by entry: BusinessStatementEntry)
    func showAllStatements()
    func openDetails(of statementID: String)
}

public final class StatementsViewModel: StatementsViewModeling {
    public var presentedStatements: BusinessStatementsGroup?
    private var statements: BusinessStatementsGroup?
    
    private let useCases: StatementViewModelUseCases
    private let coordinator: StatementsCoordinating
    weak var viewController: StatementsViewControllerDisplay?
    
    public init(useCases: StatementViewModelUseCases, coordinator: StatementsCoordinating) {
        self.useCases = useCases
        self.coordinator = coordinator
    }
    
    public func fetchStatements() async {
        do {
            self.presentedStatements = try await useCases.executeFetchStatements()
            self.statements = presentedStatements
            successStatementsFetchHandler()
        } catch {
            viewController?.showErrorAlert()
            viewController?.hideSkeleton()
        }
    }
    
    public func refreshStatements() async {
        viewController?.showSkeleton()
        await fetchStatements()
        viewController?.setFilterToAll()
    }
    
    public func successStatementsFetchHandler() {
        viewController?.reloadTable()
        viewController?.hideSkeleton()
    }
    
    public func filterStatements(by entry: BusinessStatementEntry) {
        let filtered = statements?.group.filter { group in
            group.statements.contains(where: { $0.type == entry })
        }
        
        self.presentedStatements = .init(group: filtered ?? [])
    }
    
    public func showAllStatements() {
        self.presentedStatements = statements
    }
    
    public func openDetails(of statementID: String) {
        coordinator.openDetails(of: statementID)
    }
    
}
