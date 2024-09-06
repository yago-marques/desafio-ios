//
//  Network.swift
//  Networking
//
//  Created by Yago Marques on 30/08/24.
//

import Foundation

public protocol HTTPClient {
    func executeHTTP(endpoint: Endpoint) async throws -> Response
    func executeHTTP(endpoint: Endpoint, completionHandler: @escaping (Result<Response, Error>) -> Void)
}

final public class Network: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .init(configuration: .default)) {
        self.session = session
    }
    
    public func executeHTTP(endpoint: Endpoint) async throws -> Response {
        Log.analyze(endpoint)
        
        guard let request = try await endpoint.request() else {
            Log.message("error to build request", .failure)
            return .stoped(reason: "error to build request")
        }
        
        Log.request(request)
            
        let (data, response) = try await session.data(for: request)
        
        Log.message("endpoint called", .success)
        Log.data(data)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            Log.message("invalid response", .failure)
            return .stoped(reason: "invalid response")
        }
        
        Log.response(httpResponse)
        
        return .finished(code: httpResponse.statusCode, data: data)
    }
    
    public func executeHTTP(endpoint: Endpoint, completionHandler: @escaping (Result<Response, Error>) -> Void) {
        Log.analyze(endpoint)
        
        endpoint.request { result in
            switch result {
            case .success(let request):
                guard let request = request else {
                    Log.message("error to build request", .failure)
                    completionHandler(.success(.stoped(reason: "error to build request")))
                    return
                }
                
                Log.request(request)
                
                let task = self.session.dataTask(with: request) { data, response, error in
                    if let error = error {
                        Log.message("error in network call", .failure)
                        completionHandler(.failure(error))
                        return
                    }
                    
                    guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                        Log.message("invalid response", .failure)
                        completionHandler(.success(.stoped(reason: "invalid response")))
                        return
                    }
                    
                    Log.message("endpoint called", .success)
                    Log.data(data)
                    Log.response(httpResponse)
                    
                    completionHandler(.success(.finished(code: httpResponse.statusCode, data: data)))
                }
                
                task.resume()
                
            case .failure(let error):
                Log.message("error to build request", .failure)
                completionHandler(.failure(error))
            }
        }
    }
}
