//
//  CountriesDataService.swift
//  MedlyInterviewProject
//
//  Created by Arturo Reyes on 8/7/21.
//

import Foundation
import Combine

public protocol CountriesDataServiceProtocol {
    func fetchCountries() -> AnyPublisher<[Country], Error>
}

public struct CountriesDataService: CountriesDataServiceProtocol {
    public func fetchCountries() -> AnyPublisher<[Country], Error> {
        let router = NetworkRouter<CountriesEndpoint>()
        return router.request(CountriesEndpoint())
    }
}



//https://stackoverflow.com/questions/38619660/is-it-possible-to-pass-generic-protocols-into-a-constructor-for-proper-dependenc/38783822#38783822
public struct CountriesDataService2<Router: NetworkRouterProtocol>: CountriesDataServiceProtocol where Router.Endpoint == CountriesEndpoint {
    
    let router: Router
    
    public func fetchCountries() -> AnyPublisher<[Country], Error> {
        return router.request(CountriesEndpoint())
    }
}

public protocol CountriesDataServiceProtocol2 {
    associatedtype Router: NetworkRouterProtocol
    func fetchCountries() -> AnyPublisher<[Country], Error>
}


