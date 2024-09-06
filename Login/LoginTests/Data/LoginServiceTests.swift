//
//  LoginServiceTests.swift
//  LoginTests
//
//  Created by Yago Marques on 03/09/24.
//

import Foundation
import XCTest
import Login
import Networking

typealias LoginServiceSUT = (
    sut: LoginService,
    httpClient: HttpClientMock
)

final class LoginServiceTests: XCTestCase {
    
    func test_ExecuteLoginAuth_InAnySituation_ShouldCallHTTPClient() async throws {
        let (sut, httpClient) = makeSUT()
        let cpf = "12345678910"
        let password = "123456"
        
        let _ = try await sut.executeLoginAuth(with: .init(cpf: cpf, password: password))
        
        XCTAssertTrue(httpClient.httpClientCalled)
    }
    
    func test_ExecuteLoginAuth_WhenDataIsCorrect_ShouldReturnValidToken() async throws {
        let (sut, _) = makeSUT()
        let cpf = "12345678910"
        let password = "123456"
        
        let result = try await sut.executeLoginAuth(with: .init(cpf: cpf, password: password))
        
        XCTAssertFalse(result.token.isEmpty)
    }
    
    func test_ExecuteLoginAuth_WhenDataIsNotCorrect_ShouldReturnStatusCodeError() async {
        let (sut, httpClient) = makeSUT()
        httpClient.dataIsCorrect = false
        let cpf = "123456789"
        let password = "123456"
                
        do {
            let _ = try await sut.executeLoginAuth(with: .init(cpf: cpf, password: password))
            XCTFail()
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_ExecuteLoginAuth_WhenResponseDataIsEmpty_ShouldReturnEmptyDataError() async {
        let (sut, httpClient) = makeSUT()
        httpClient.emptyBodyResponse = true
        let cpf = "12345678910"
        let password = "123456"
                
        do {
            let _ = try await sut.executeLoginAuth(with: .init(cpf: cpf, password: password))
            XCTFail()
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_ExecuteLoginAuth_WhenResponseDataIsInvalid_ShouldReturnInvalidResponseError() async {
        let (sut, httpClient) = makeSUT()
        httpClient.returnValidResponse = false
        let cpf = "12345678910"
        let password = "123456"
                
        do {
            let _ = try await sut.executeLoginAuth(with: .init(cpf: cpf, password: password))
            XCTFail()
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
}

private extension LoginServiceTests {
    func makeSUT() -> LoginServiceSUT {
        let httpClient = HttpClientMock()
        let sut = LoginService(httpClient: httpClient)
        
        return (sut, httpClient)
    }
}
