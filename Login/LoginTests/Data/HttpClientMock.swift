//
//  HttpClientMock.swift
//  LoginTests
//
//  Created by Yago Marques on 03/09/24.
//

import Foundation
import Login
import Networking
import Commons

final class HttpClientMock: HTTPClient {
    var httpClientCalled: Bool = false
    var dataIsCorrect: Bool = true
    var emptyBodyResponse = false
    var returnValidResponse = true
    let validResponse = """
    {
        "token": "mytoken"
    }
    """.data(using: .utf8)
    
    let invalidResponse = """
    {
        "anything": "anything"
    }
    """.data(using: .utf8)
    
    lazy var mockedResponse = emptyBodyResponse ? nil : returnValidResponse ? validResponse : invalidResponse
    
    func executeHTTP(endpoint: Endpoint) async throws -> Response {
        httpClientCalled = true
        
        return .init(
            code: dataIsCorrect ? 200 : 401,
            data: dataIsCorrect ? mockedResponse : nil,
            status: .finished
        )
    }
    
    func executeHTTP(endpoint: Endpoint, completionHandler: @escaping (Result<Response, Error>) -> Void) {
        httpClientCalled = true
        
        completionHandler(.success(.init(
            code: dataIsCorrect ? 200 : 401,
            data: dataIsCorrect ? mockedResponse : nil,
            status: .finished
        )))
    }
}
