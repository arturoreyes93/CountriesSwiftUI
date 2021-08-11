//
//  CountriesDataServiceTests.swift
//  MedlyInterviewProjectTests
//
//  Created by Arturo Reyes on 8/10/21.
//

import XCTest
import Combine
@testable import MedlyInterviewProject

class CountriesDataServiceTests: XCTestCase {
    
    var sut: CountriesDataService2<CountriesNetworkRouterMock>!
    
    var networkRouter: CountriesNetworkRouterMock!

    override func setUp() {
        networkRouter = CountriesNetworkRouterMock()
        sut = CountriesDataService2(router: CountriesNetworkRouterMock())
    }
    

    override func tearDown()  {
        sut = nil
        networkRouter = nil
    }

    func testFetchCountriesSuccess() throws {
        networkRouter.testResult = .success
        let result = try awaitCompletion(of: sut.fetchCountries())
        XCTAssert(!result[0].isEmpty)
    }
    
    func testFetchCountriesFail_noData() throws {
        let expectedError = NetworkError.noData
        networkRouter.testResult = .error(expectedError)
        
        do {
            let _ = try awaitCompletion(of: sut.fetchCountries())
        } catch let error {
            if let error = error as? NetworkError {
                XCTAssertEqual(error, expectedError)
            } else {
                XCTFail("Error type different than expected")
            }
            
        }
    }
    
    func testFetchCountriesFail_badStatusCode() throws {
        let expectedError = NetworkError.badHTTPStatusCode(404)
        networkRouter.testResult = .error(expectedError)
        
        do {
            let _ = try awaitCompletion(of: sut.fetchCountries())
        } catch let error {
            if let error = error as? NetworkError {
                XCTAssertEqual(error, expectedError)
            } else {
                XCTFail("Error type different than expected")
            }
            
        }
    }
}
