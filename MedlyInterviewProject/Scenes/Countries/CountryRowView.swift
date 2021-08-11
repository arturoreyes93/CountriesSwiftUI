//
//  CountryRowView.swift
//  MedlyInterviewProject
//
//  Created by Arturo Reyes on 8/8/21.
//

import SwiftUI

struct CountryRowView: View {
    
    @ObservedObject private var loader: ImageLoader
    
    var country: Country
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            flagImage
            VStack(alignment: .leading, spacing: 5) {
                countryName
                countryCapital
            }
            .padding(.vertical, 10)
        }
        .onAppear(perform: loader.load)
        .onDisappear(perform: loader.cancel)
    }
    
    private var countryName: some View {
        Text(country.name)
            .font(.headline)
    }
    
    private var countryCapital: some View {
        Text(country.capital)
            .font(.footnote)
            .foregroundColor(.secondary)
    }
    
    private var mexicanFlag: some View {
        Image("mexican-flag")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100)
            //.cornerRadius(5)
            //.overlay(RoundedRectangle(cornerRadius: 10)
                    //.stroke(Color.orange, lineWidth: 2))
    }
    
    @ViewBuilder private var flagImage: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 10)
                    //.cornerRadius(5)
                    //.overlay(RoundedRectangle(cornerRadius: 5)
                            //.stroke(Color.orange, lineWidth: 2))
            } else {
                spinner
            }
        }
        .frame(width: 100)
        
    }
    
    private var spinner: some View {
        Spinner(isAnimating: true, style: .medium)
    }
    
    public init(country: Country, loader: ImageLoader) {
        self.country = country
        self.loader = loader
    }
}
//
//struct CountryRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountryRowView(country: Country(id: UUID().uuidString, name: "Mexico", alpha2Code: "", capital: "DF", region: ""))
//    }
//}
