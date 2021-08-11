//
//  CountriesViewModelTestts.swift
//  CountriesSwiftUITests
//
//  Created by Arturo Reyes on 8/11/21.
//

import XCTest
import Combine
@testable import CountriesSwiftUI

class CountriesViewModelTestts: XCTestCase {
    
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
//        service.testResult = .success
//
//        var loadedCountries: [Country] = []
//        var loadedState: CountriesViewModel
//        let expectation = expectation(description: "Loaded countries successfully")
//        sut.loadCountries()
//        let _ = sut.$state
//            .receive(on: RunLoop.main)
//            .sink { <#Subscribers.Completion<Published<CountriesViewModel.State>.Publisher.Failure>#> in
//                <#code#>
//            } receiveValue: { <#Published<CountriesViewModel.State>.Publisher.Output#> in
//                <#code#>
//            }
//
//
//        wait(for: [expectation], timeout: 5)
//        XCTAssert(!loadedCountries.isEmpty)
//        XCTAssert(sut.state == .loaded(loadedCountries))
    }
    
    func testFetchCountriesFail_noData() throws {
//        let expectedError = NetworkError.noData
//        service.testResult = .error(expectedError)

    }
    
    func testFetchCountriesFail_badStatusCode() throws {
//        let expectedError = NetworkError.badHTTPStatusCode(404)
//        service.testResult = .error(expectedError)

    }

}
