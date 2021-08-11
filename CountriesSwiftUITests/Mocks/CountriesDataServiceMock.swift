//
//  CountriesDataServiceMock.swift
//  CountriesSwiftUITests
//
//  Created by Arturo Reyes on 8/11/21.
//

import XCTest
import Combine
@testable import CountriesSwiftUI

class CountriesDataServiceMock: CountriesDataServiceProtocol {
    
    enum TestResult {
        case success
        case error(Error)
    }
    
    static var fetchedCountries: [Country] = []
    var testResult: TestResult = .success
    let testData = TestDataManager()
    
    func fetchCountries() -> AnyPublisher<[Country], Error> {
        
        func decodedResult(data: Data) -> AnyPublisher<[Country], Error> {
            return testData.decode(data)
        }
        
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
