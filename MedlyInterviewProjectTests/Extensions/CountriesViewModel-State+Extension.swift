//
//  CountriesViewModel-State+Extension.swift
//  MedlyInterviewProjectTests
//
//  Created by Arturo Reyes on 8/11/21.
//

import Foundation
@testable import MedlyInterviewProject

extension CountriesViewModel.State: Equatable {
    public static func == (lhs: CountriesViewModel.State, rhs: CountriesViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.loaded(let lhsCountries), .loaded(let rhsCountries)):
            return lhsCountries == rhsCountries
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
