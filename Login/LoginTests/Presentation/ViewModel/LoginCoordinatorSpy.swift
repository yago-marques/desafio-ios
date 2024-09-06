//
//  LoginCoordinatorSpy.swift
//  LoginTests
//
//  Created by Yago Marques on 03/09/24.
//

import Foundation
import Login

final class LoginCoordinatorSpy: LoginCoordinating {
    enum Message: Equatable {
        case openCpfPickerCalled
        case openPasswordPickerCalled
        case popCalled
        case openStatementsCalled
    }
    
    var receivedMessages = [Message]()
    
    func openCpfPicker(viewModel: LoginViewModel) {
        receivedMessages.append(.openCpfPickerCalled)
    }
    
    func openPasswordPicker(viewModel: LoginViewModel) {
        receivedMessages.append(.openPasswordPickerCalled)
    }
    
    func pop() {
        receivedMessages.append(.popCalled)
    }
    
    func openStatements() {
        receivedMessages.append(.openStatementsCalled)
    }
}
