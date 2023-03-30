//
//  LocationSearchResultsViewModel.swift
//  Foods With Friends
//
//  Created by Julia Zorc (student LM) on 3/23/23.
//


import Foundation
import MapKit
import Combine

@MainActor
class SearchResultsViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    var cancellable: AnyCancellable?
    
    init() {
        cancellable = $searchText.debounce(for: .seconds(0.25), scheduler: DispatchQueue.main)
            .sink { value in
                if !value.isEmpty && value.count > 3 {
                    self.search(text: value)
                } else {
                    self.restaurants = []
                }
            }
    }
    
    @Published var restaurants = [RestaurantListView]()
    
    func search(text: String) {
        
        searchRequest.naturalLanguageQuery = text
                
        search.start { response, error in
            
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
        }
    }
}
