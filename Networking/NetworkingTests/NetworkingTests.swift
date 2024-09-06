//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Yago Marques on 29/08/24.
//

import XCTest
import Networking



private enum APIResponseError: Error {
    case invalidURL
    case invalidResponse
}

final class NetworkingTests: XCTestCase {

    func test_ExecuteHTTP_WhenEndpointIsCorrect_ShouldReturnValidDataAndCodeOnFinishedResponse() async throws {
        let sut = makeSUT(for: simpleCorrectGetHandler)
        
        let response = try await sut.executeHTTP(endpoint: MockedEndpoint.simpleCorrectGet)
        
        XCTAssertEqual(response.status, .finished)
        XCTAssertNotNil(response.data)
        XCTAssertEqual(response.code, 200)
    }
    
    func test_ExecuteHTTP_WhenEndpointIsIncorrect_ShouldReturnStopedResponse() async throws {
        let sut = makeSUT(for: simpleCorrectGetHandler)
        
        let response = try await sut.executeHTTP(endpoint: MockedEndpoint.simpleIncorrectGet)
        
        XCTAssertEqual(response.status, .stoped(reason: "error to build request"))
        XCTAssertNil(response.data)
        XCTAssertNil(response.code)
    }
    
    func test_ExecuteHTTP_WhenEndpointIsCorrectButResponseIsNotHTTP_ShouldReturnStopedResponse() async throws {
        let sut = makeSUT(for: simpleIncorrectGetHandler)
        
        let response = try await sut.executeHTTP(endpoint: MockedEndpoint.simpleCorrectGet)
        
        XCTAssertEqual(response.status, .stoped(reason: "invalid response"))
        XCTAssertNil(response.data)
        XCTAssertNil(response.code)
    }

}

private extension NetworkingTests {
    func makeSUT(for handler: @escaping (URLRequest) throws -> (URLResponse, Data?)) -> Network {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLSession.self]
        let urlSession = URLSession(configuration: configuration)
        MockURLSession.requestHandler = handler
        
        return Network(session: urlSession)
    }
    
    func simpleCorrectGetHandler(_ request: URLRequest) throws -> (URLResponse, Data?) {
        guard let url = request.url else { throw APIResponseError.invalidURL }
        
        guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: request.allHTTPHeaderFields) else {
            throw APIResponseError.invalidResponse
        }
        
        return (response, nil)
    }
    
    func simpleIncorrectGetHandler(_ request: URLRequest) throws -> (URLResponse, Data?) {
        let json = """
        {
            "status": "success"
        }
        """
        let data = json.data(using: .utf8)
        
        let response = URLResponse()
        
        return (response, data)
    }
}

private enum MockedEndpoint: Endpoint {
    case simpleCorrectGet
    case simpleIncorrectGet
    
    var baseUrl: String {
        "https://versus.com"
    }
    
    var path: String {
        switch self {
        case .simpleCorrectGet:
            "/correct"
        case .simpleIncorrectGet:
            "incorrect"
        }
        
    }
    
    var method: HTTPMethod {
        .GET
    }
    
    var queries: [String : String] {
        ["page": "3"]
    }
    
    var headers: [String : String] {
        ["x-api-key": "my-key"]
    }
    
    var body: Data? {
        nil
    }
    
    var tokenNeeded: Bool {
        false
    }
}
