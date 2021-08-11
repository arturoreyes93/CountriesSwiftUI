//
//  CountriesViewModelTestts.swift
//  CountriesSwiftUITests
//
//  Created by Arturo Reyes on 8/11/21.
//

import XCTest
import Combine
@testable import CountriesSwiftUI

class CountriesViewModelTests: XCTestCase {
    
    var sut: CountriesViewModel!
    
    var service: CountriesDataServiceMock!

    override func setUp() {
        service = CountriesDataServiceMock()
        sut = CountriesViewModel(service: service)
    }

    override func tearDown() {
        sut = nil
        service = nil
    }
    
    func testViewModelInitialState() {
        XCTAssert(sut.state == .loading)
    }
    
    func testFetchCountriesSuccess() throws {
        service.testResult = .success
        
        var cancellables = Set<AnyCancellable>()
        var loadedCountries: [Country] = []
        let expectation = expectation(description: "testFetchCountriesSuccess passed")
        
        let _ = sut.$state
            .sink { state in
                if case .loaded(let countries) = state {
                    XCTAssert(!countries.isEmpty)
                    loadedCountries.append(contentsOf: countries)
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.loadCountries()
        wait(for: [expectation], timeout: 1)
        XCTAssert(!loadedCountries.isEmpty)
        XCTAssert(sut.state == .loaded(loadedCountries))
    }
    
    func testFetchCountriesFail_noData() throws {
        service.testResult = .error(NetworkError.noData)
        
        var cancellables = Set<AnyCancellable>()
        var expectedError: NetworkError?
        let expectation = expectation(description: "testFetchCountriesFail_noData passed")
        
        let _ = sut.$state
            .sink { state in
                if case .error(let error) = state {
                    if let networkError = error as? NetworkError {
                        expectedError = networkError
                        expectation.fulfill()
                    }
                }
            }.store(in: &cancellables)
        
        sut.loadCountries()
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(expectedError)
        XCTAssert(sut.state == .error(expectedError!))
        
    }
    
    func testFetchCountriesFail_badStatusCode() throws {
        service.testResult = .error(NetworkError.badHTTPStatusCode(404))
        
        var cancellables = Set<AnyCancellable>()
        var expectedError: NetworkError?
        let expectation = expectation(description: "testFetchCountriesFail_noData passed")
        
        let _ = sut.$state
            .sink { state in
                if case .error(let error) = state {
                    if let networkError = error as? NetworkError {
                        expectedError = networkError
                        expectation.fulfill()
                    }
                }
            }.store(in: &cancellables)
        
        sut.loadCountries()
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(expectedError)
        XCTAssert(sut.state == .error(expectedError!))

    }

}
