//
//  CountriesEndpoint.swift
//  CountriesSwiftUI
//
//  Created by Arturo Reyes on 8/10/21.
//

import Foundation

public struct CountriesEndpoint: URLEndPoint {
    
    enum Filter: String, CaseIterable {
        case name
        case alpha2Code
        case capital
        case population
        case timezones
    }
    
    public typealias Response = [Country]
    public let baseURL: URL = URL(string: "https://restcountries.eu/")!
    public let httpMethod: HTTPMethod = .GET
    
    let basePath: String = "rest/v2/all"
    
    public var path: String {
        var completePath: String = basePath
        
        if !activeFilters.isEmpty {
            completePath.append("?fields=")
            
            for filter in activeFilters.enumerated() {
                completePath.append(filter.1.rawValue)
                
                if filter.0 != activeFilters.count - 1 {
                    completePath.append(";")
                }
            }
        }
        
        return completePath
    }
    
    var activeFilters: [Filter] = []

}
