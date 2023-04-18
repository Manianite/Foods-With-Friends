//
//  SearchView.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/7/23.
//

import SwiftUI
import struct Kingfisher.KFImage
import FirebaseAuth

struct SearchView: View {
    
    @StateObject var data = FetchRestaurantData()
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var appUser: User
    @State private var query: String = ""
    
    var body: some View {

        VStack{
            NavigationView {
                VStack{
                    
                    List {
                        ForEach($data.response.restaurants) {restaurant in
                            NavigationLink {
                                RestaurantInfoView(restaurant: restaurant)
                            } label: {
                                RestaurantListView(restaurant: restaurant)
                            }
                        }
                        
                    }
                    .listStyle(.grouped)
                    .font(Constants.titleFont)
                    
                }.searchable(text: $query, prompt: "Search Restaurants")
                    .font(Constants.titleFont)
                    .navigationTitle("Search Restaurants")
                    .font(Constants.textFont)
                    .navigationBarTitleDisplayMode(.inline)
        //            .navigationViewStyle(.stack)
            }.onSubmit(of: .search, runSearch)

        }
       
    }
    
    func runSearch() {
        Task{
            await data.getData(query, locationManager)
            let restaurantList: [Restaurant] = data.response.restaurants
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(User())
            .environmentObject(LocationManager())
    }
}
