//
//  FlagEndPoint.swift
//  CountriesSwiftUI
//
//  Created by Arturo Reyes on 8/10/21.
//

import Foundation

struct FlagEndPoint: URLEndPoint {
    typealias Response = AnyDecodable
    
    let baseURL: URL = URL(string: "https://www.countryflags.io/")!
    let httpMethod: HTTPMethod = .GET
    let alphaCode: String
    
    var path: String {
        return "\(alphaCode)/flat/64.png"
    }
    
    var url: URL {
        return baseURL.appendingPathComponent(path)
    }
}
