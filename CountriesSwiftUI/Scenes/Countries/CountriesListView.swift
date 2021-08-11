//
//  ContentView.swift
//  CountriesSwiftUI
//
//  Created by Arturo Reyes on 8/7/21.
//

import SwiftUI

struct CountriesListView: View {
    
    @ObservedObject var viewModel: CountriesViewModel
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitle("World Nations")
        }
        .onAppear { self.viewModel.loadCountries() }
    }
    
    // Wrap inside AnyView() alternatively
    @ViewBuilder private var content: some View {
        switch viewModel.state {
        case .loading:
            Spinner(isAnimating: true, style: .large)
        case .error(let error):
            Text(error.localizedDescription)
        case .loaded(let countries):
            list(of: countries)
        }
    }
    
    init(viewModel: CountriesViewModel = CountriesViewModel()) {
        self.viewModel = viewModel
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    private func list(of countries: [Country]) -> some View {
        return List(countries) { country in
            let flagImageEndpoint = FlagEndPoint(alphaCode: country.alpha2Code)
            CountryRowView(country: country,
                           loader: ImageLoader(url: flagImageEndpoint.url,
                                               cache: viewModel.cache))
        }
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountriesListView(viewModel: CountriesViewModel())
//    }
//}
