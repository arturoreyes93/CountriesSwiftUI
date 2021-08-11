//
//  CountriesEndpoint.swift
//  MedlyInterviewProject
//
//  Created by Arturo Reyes on 8/10/21.
//

import Foundation

public struct CountriesEndpoint: URLEndPoint {
    public typealias Response = [Country]
    public let baseURL: URL = URL(string: "https://restcountries.eu/")!
    public let path: String = "rest/v2/all"
    public let httpMethod: HTTPMethod = .GET
}
