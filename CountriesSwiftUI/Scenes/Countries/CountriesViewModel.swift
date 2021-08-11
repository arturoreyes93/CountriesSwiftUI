//
//  CountriesViewModel.swift
//  CountriesSwiftUI
//
//  Created by Arturo Reyes on 8/7/21.
//

import Foundation
import Combine
import SwiftUI

final class CountriesViewModel: ObservableObject {

    enum State {
        case loading
        case loaded([Country])
        case error(Error)
    }
    
    @Published private(set) var state = State.loading
    
    @Environment(\.imageCache) var cache: ImageCache
    
    private let service: CountriesDataServiceProtocol
    
    // Link the publisher life span to the viewModel's
    private var token: AnyCancellable?
    
    init(service: CountriesDataServiceProtocol = CountriesDataService()) {
        self.service = service
    }
    
    func loadCountries() {
        token = service.fetchCountries()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error)
                case .finished:
                    print("Did finish fetchCountries")
                }
            }, receiveValue: { [weak self] countries in
                self?.state = .loaded(countries)
            })
    }
    
}
