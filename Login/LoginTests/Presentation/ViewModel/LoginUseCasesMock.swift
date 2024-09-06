//
//  LoginUseCasesMock.swift
//  LoginTests
//
//  Created by Yago Marques on 03/09/24.
//

import Foundation
import Login

struct LoginUseCasesMockError: Error { }

final class LoginUseCasesMock: LoginViewModelUseCases {
    var executeLoginAuthCalled = false
    var shouldThrowError = false
    
    func executeLoginAuth(with request: LoginRequest) async throws -> LoginResponse {
        executeLoginAuthCalled = true
        
        if shouldThrowError {
            throw LoginUseCasesMockError()
        }
        
        return .init(token: "myToken")
    }
}
