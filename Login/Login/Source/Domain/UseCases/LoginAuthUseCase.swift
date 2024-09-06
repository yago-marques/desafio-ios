//
//  LoginAuth.swift
//  Login
//
//  Created by Yago Marques on 30/08/24.
//

import Foundation

public protocol LoginAuthUseCase {
    func executeLoginAuth(with request: LoginRequest) async throws -> LoginResponse
}
