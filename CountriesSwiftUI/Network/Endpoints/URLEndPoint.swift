//
//  URLEndPoint.swift
//  CountriesSwiftUI
//
//  Created by Arturo Reyes on 8/7/21.
//

import Foundation

public protocol URLEndPoint {
    associatedtype Response: Decodable // can it be used with enum with different Response types per enum case?
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
}

struct AnyDecodable: Decodable { }
