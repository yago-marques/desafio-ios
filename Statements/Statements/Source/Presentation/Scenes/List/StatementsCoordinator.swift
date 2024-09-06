//
//  StatementsCoordinator.swift
//  Statements
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation
import Coordinator

public protocol StatementsCoordinating { 
    func openDetails(of id: String)
}

public final class StatementsCoordinator: StatementsCoordinating {
    private let coordinator: Coordinating
    
    public init(coordinator: Coordinating) {
        self.coordinator = coordinator
    }
    
    public func openDetails(of id: String) {
        let viewController = StatementDetailsFactory.make(id: id)
        coordinator.send(.push(viewController))
    }
}
