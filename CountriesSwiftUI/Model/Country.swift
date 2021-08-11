//
//  Country.swift
//  CountriesSwiftUI
//
//  Created by Arturo Reyes on 8/8/21.
//

import Foundation

public struct Country: Identifiable {
    public var id: String
    var name: String
    var alpha2Code: String
    var capital: String
    var region: String
}

extension Country: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case alpha2Code
        case capital
        case region
    }
    
    public init(from decoder: Decoder) throws {
        id = UUID().uuidString
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        alpha2Code = try container.decode(String.self, forKey: .alpha2Code)
        capital = try container.decode(String.self, forKey: .capital)
        region = try container.decode(String.self, forKey: .region)
    }
}
