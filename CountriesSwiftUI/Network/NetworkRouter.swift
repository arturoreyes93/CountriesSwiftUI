//
//  NetworkRouter.swift
//  CountriesSwiftUI
//
//  Created by Arturo Reyes on 8/8/21.
//

import Foundation
import Combine

public protocol NetworkRouterProtocol {
    associatedtype Endpoint: URLEndPoint
    func request(_ route: Endpoint) -> AnyPublisher<Endpoint.Response, Error>
}

public struct NetworkRouter<Endpoint: URLEndPoint>: NetworkRouterProtocol {
    
    public typealias Endpoint = Endpoint
    
    private let session: URLSession = URLSession.shared
    
    public func request(_ route: Endpoint) -> AnyPublisher<Endpoint.Response, Error> {
        let urlString = route.baseURL.appendingPathComponent(route.path).absoluteString.removingPercentEncoding! // Here is why it didn't work -> https://stackoverflow.com/a/53955868/7388643
        print("URL -> \(urlString)")
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = route.httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return session
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                    throw NetworkError.noData
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    throw NetworkError.badHTTPStatusCode(statusCode)
                }
                
                data.log()
                
                return data
            }
            .decode(type: Endpoint.Response.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
}

extension Data {
    var utf8String: String {
        return String(data: self, encoding: .utf8) ?? "Unable to encode data with UTF8 encoding"
    }
    
    func log() {
        print(utf8String)
    }
}
