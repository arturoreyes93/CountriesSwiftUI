//
//  TestDataManager.swift
//  CountriesSwiftUITests
//
//  Created by Arturo Reyes on 8/10/21.
//

import Foundation
import Combine
@testable import CountriesSwiftUI

class TestDataManager {
    
    enum TestData: String {
        case Countries
    }
    
    func dataFor(file: TestData) throws -> Data {
    
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: file.rawValue, withExtension: "json") else {
            throw NSError(domain: String(describing: Self.Type.self),
                          code: 0, userInfo:
                            ["description":"Could not find bundle url for file with name \(file)"])
        }

        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let error {
            throw error
        }
    }
    
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, Error> {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .secondsSince1970

      return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError({ error -> Error in
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .dataCorrupted(let context):
                    print(context)
                case .keyNotFound(let key, let context):
                    print("Key '\(key)' not found:", context.debugDescription)
                case .valueNotFound(let value, let context):
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                case .typeMismatch(let type, let context):
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                default:
                    print(error.localizedDescription)
                }
            }
            
            return error
            
        })
        .eraseToAnyPublisher()
    }

}
