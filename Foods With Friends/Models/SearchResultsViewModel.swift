//
//  SearchResultsViewModel.swift
//  Foods With Friends
//
//  Created by Julia Zorc (student LM) on 3/20/23.
//

import Foundation
import MapKit
import Combine

@MainActor
class SearchResultsViewModel: ObservableObject {
    
    @Published var searchText: String = ""
//    var cancellable: AnyCancellable?
//    
//    init() {
//        cancellable = $searchText.debounce(for: .seconds(0.25), scheduler: DispatchQueue.main)
//            .sink { value in
//                if !value.isEmpty && value.count > 3 {
//                    self.search(text: value, region: LocationManager.shared.region)
//                } else {
//                 //   self.places = []
//                }
//            }
//    }
    
    func search(text: String, region: MKCoordinateRegion) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = region

        let search = MKLocalSearch(request: searchRequest)

        search.start { response, error in
            guard let response = response else {
                print(error?.localizedDescription)
                return
            }

        }
    }
    
}
