//
//  XCTestCase+Extension.swift
//  CountriesSwiftUITests
//
//  Created by Arturo Reyes on 8/10/21.
//

import Foundation
import Combine
import XCTest

extension XCTestCase {
    func awaitCompletion<T: Publisher>(of publisher: T, timeout: TimeInterval = 1) throws -> [T.Output] {
        // An expectation lets us await the result of an asynchronous
        // operation in a synchronous manner:
        let expectation =  self.expectation(description: "Awaiting publisher completion")

        var completion: Subscribers.Completion<T.Failure>?
        var output = [T.Output]()

        let cancellable = publisher.sink {
            completion = $0
            expectation.fulfill()
        } receiveValue: {
            output.append($0)
        }

        // Our test execution will stop at this point until our
        // expectation has been fulfilled, or until the given timeout
        // interval has elapsed:
        waitForExpectations(timeout: timeout)

        switch completion {
        case .failure(let error):
            throw error
        case .finished:
            return output
        case nil:
            // If we enter this code path, then our test has
            // already been marked as failing, since our
            // expectation was never fullfilled.
            cancellable.cancel()
            return []
        }
    }
}
