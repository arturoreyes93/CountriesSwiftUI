//
//  NetworkError+Extension.swift
//  MedlyInterviewProjectTests
//
//  Created by Arturo Reyes on 8/11/21.
//

import Foundation
@testable import MedlyInterviewProject

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.noData, .noData):
            return true
        case (.badHTTPStatusCode(let lhsStatusCode), .badHTTPStatusCode(let rhsStatusCode)):
            return lhsStatusCode == rhsStatusCode
        default:
            return false
        }
    }
}
