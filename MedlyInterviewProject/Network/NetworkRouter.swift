//
//  NetworkRouter.swift
//  MedlyInterviewProject
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
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path))
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
                
                return data
            }
            .decode(type: Endpoint.Response.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
//            .tryMap({ data, response -> Data in
//
//                guard let (response as? HTTPURLResponse)?.s
//                return data
//            })
    }
}
