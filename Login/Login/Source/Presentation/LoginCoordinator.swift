//
//  LoginCoordinador.swift
//  Login
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation
import Coordinator
import Statements
import Extensions

public protocol LoginCoordinating {
    func openCpfPicker(viewModel: LoginViewModel)
    func openPasswordPicker(viewModel: LoginViewModel)
    func pop()
    func openStatements()
}

public final class LoginCoordinator {
    private let coordinator: Coordinating
    
    public init(coordinator: Coordinating) {
        self.coordinator = coordinator
    }
}

extension LoginCoordinator: LoginCoordinating {
    public func openCpfPicker(viewModel: LoginViewModel) {
        coordinator.send(.push(CPFPickerView(viewModel: viewModel).toViewController()))
    }
    
    public func openPasswordPicker(viewModel: LoginViewModel) {
        coordinator.send(.push(PasswordPickerView(viewModel: viewModel).toViewController()))
    }
    
    public func pop() {
        coordinator.send(.pop)
    }
    
    public func openStatements() {
        coordinator.send(.push(StatementsFactory.make(with: self.coordinator)))
    }
}
