//
//  LoginEndpointTests.swift
//  LoginTests
//
//  Created by Yago Marques on 03/09/24.
//

import Foundation
import XCTest
import Login
import Networking
import EnvironmentHelper

final class LoginEndpointTests: XCTestCase {
    
    func test_AuthLoginEndpoint_WhenCall_ShouldMapAllFieldsCorrect() async {
        let request = LoginRequest(cpf: "12345678910", password: "123456")
        
        let sut = LoginEndpoint.auth(request)
        
        XCTAssertEqual(sut.baseUrl, "https://\(EnvironmentHelper.shared.fetch(for: .coraBaseURL) ?? "")")
        XCTAssertEqual(sut.path, "/challenge/auth")
        XCTAssertEqual(sut.method.rawValue, "POST")
        XCTAssertEqual(sut.queries, [:])
        XCTAssertTrue(sut.headers.contains(where: { $0.key == "apikey" }))
        XCTAssertFalse(sut.tokenNeeded)
        XCTAssertNotNil(sut.body)
    }
    
}

