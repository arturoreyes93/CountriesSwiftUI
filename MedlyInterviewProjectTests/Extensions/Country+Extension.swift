//
//  Country+Extension.swift
//  MedlyInterviewProjectTests
//
//  Created by Arturo Reyes on 8/11/21.
//

import Foundation
@testable import MedlyInterviewProject

extension Country: Equatable {
    public static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.id == rhs.id
    }
}
