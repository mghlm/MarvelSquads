//
//  APIService.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 02/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import Foundation

protocol APIServiceType {
    
    /// Sends an API request with URLSession
    ///
    /// - Parameters:
    ///   - endpoint: Endoint with info about request
    ///   - completion: Result type, can either complete with JSON or Error
    func request<T: Decodable>(type: T.Type, endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class APIService: APIServiceType {
    
    // MARK: - Private properties
    
    private var urlSession: URLSession
    private var transformer: Transformer
    
    // MARK: - Init
    
    init(urlSession: URLSession = URLSession.shared, transformer: Transformer = JSONTransformer()) {
        self.urlSession = urlSession
        self.transformer = transformer
    }
    
    // MARK: - Public methods 
    
    func request<T: Decodable>(type: T.Type, endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard var urlRequest = buildRequest(for: endpoint) else { return }
        urlRequest.httpMethod = endpoint.method
        
        let task = urlSession.dataTask(with: urlRequest) { (result) in
            switch result {
            case .success(let response, let data):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidStatusCode))
                    return
                }
                do {
                    let values = try self.transformer.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(_):
                completion(.failure(.networkError))
            }
        }
        task.resume()
    }
    
    func buildRequest(for endpoint: Endpoint) -> URLRequest? {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.port = endpoint.port
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
}

enum NetworkError: String, Error {
    case invalidStatusCode = "Bad status code"
    case decodeError = "Decode error"
    case networkError = "Network error"
}
