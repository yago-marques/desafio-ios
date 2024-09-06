//
//  Endpoint.swift
//  Networking
//
//  Created by Yago Marques on 30/08/24.
//

import Foundation
import Storage

public enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queries: [String: String] { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var tokenNeeded: Bool { get }
}

extension Endpoint {
    private func queries() -> [URLQueryItem] {
        queries.map { .init(name: $0.key, value: $0.value) }
    }
    
    private func url() -> URL? {
        var components = URLComponents(string: baseUrl)
        components?.path = path
        components?.queryItems = queries()
        
        return components?.url
    }
    
    func request() async throws -> URLRequest? {
        guard let url = url() else { return nil }
        var request = URLRequest(url: url)
        request.httpBody = body
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        try await refrestTokenIfNeeded(for: &request)
        
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
    
    func request(completionHandler: @escaping (Result<URLRequest?, Error>) -> Void) {
        guard let url = url() else {
            completionHandler(.success(nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpBody = body
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        func completeRequest(with request: URLRequest) {
            var mutableRequest = request
            for header in headers {
                mutableRequest.setValue(header.value, forHTTPHeaderField: header.key)
            }
            completionHandler(.success(mutableRequest))
        }
        
        refrestTokenIfNeeded(for: request) { result in
            switch result {
            case .success(let request):
                completeRequest(with: request)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func refrestTokenIfNeeded(for request: inout URLRequest) async throws {
        if tokenNeeded, let tokenDate = Keychain.shared.getItem(for: .tokenDate) as? Date {
            if !tokenDate.isLessThanOneMinuteAgo() {
                if let newToken = try await RefreshTokenService.shared.generate() {
                    request.setValue(newToken, forHTTPHeaderField: "token")
                }
            } else {
                if let token = Keychain.shared.getItem(for: .token) as? String {
                    request.setValue(token, forHTTPHeaderField: "token")
                }
            }
        }
    }
    
    func refrestTokenIfNeeded(for request: URLRequest, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var mutableRequest = request

        if tokenNeeded, let tokenDate = Keychain.shared.getItem(for: .tokenDate) as? Date {
            if !tokenDate.isLessThanOneMinuteAgo() {
                RefreshTokenService.shared.generate { result in
                    switch result {
                    case .success(let newToken):
                        if let newToken = newToken {
                            mutableRequest.setValue(newToken, forHTTPHeaderField: "token")
                        }
                        completion(.success(mutableRequest))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else {
                if let token = Keychain.shared.getItem(for: .token) as? String {
                    mutableRequest.setValue(token, forHTTPHeaderField: "token")
                }
                completion(.success(mutableRequest))
            }
        } else {
            completion(.success(mutableRequest))
        }
    }
}

extension Date {
    func isLessThanOneMinuteAgo() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        
        let componentsNow = calendar.dateComponents([.hour, .minute], from: now)
        let componentsGivenDate = calendar.dateComponents([.hour, .minute], from: self)
        
        if componentsNow.minute != componentsGivenDate.minute || componentsNow.hour != componentsGivenDate.hour {
            return false
        } else {
            return true
        }
    }
}
