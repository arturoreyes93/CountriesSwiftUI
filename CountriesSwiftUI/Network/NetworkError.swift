//
//  NetworkError.swift
//  CountriesSwiftUI
//
//  Created by Arturo Reyes on 8/10/21.
//

import Foundation

enum NetworkError: Error {
    case noData
    case badHTTPStatusCode(Int)
}

