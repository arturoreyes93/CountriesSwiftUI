//
//  CountriesNetworkRouterMock.swift
//  MedlyInterviewProjectTests
//
//  Created by Arturo Reyes on 8/11/21.
//

import Foundation
import Combine
@testable import MedlyInterviewProject

struct CountriesNetworkRouterMock: NetworkRouterProtocol {
    typealias Endpoint = CountriesEndpoint
    
    enum TestResult {
        case success
        case error(Error)
    }
    
    var testResult: TestResult = .success
    let testData = TestDataManager()

    func request(_ route: Endpoint) -> AnyPublisher<Endpoint.Response, Error> {
        
        switch testResult {
        case .success:
            guard let countriesData = try? testData.dataFor(file: .Countries) else {
                return Fail(error: NetworkError.noData).eraseToAnyPublisher()
            }
            
            return testData.decode(countriesData)
        case .error(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
