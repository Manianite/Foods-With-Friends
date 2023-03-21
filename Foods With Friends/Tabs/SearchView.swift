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
    @EnvironmentObject var user: User
    @State var query: String = ""
    @State var waiting: Bool = false
    
    var body: some View {
        VStack{
            NavigationView {
                VStack {
                    HStack {
                        TextField("Search", text: $query)
                            .padding(.leading)
                        Button {
                            Task {
                                waiting = true
                                await data.getData(query)
                                waiting = false
                            }
                        } label: {
                            Text("Go")
                                .foregroundColor(.blue)
                                .padding(.trailing)
                        }
                    }
                    
                    if waiting {
                        Divider()
                        Text("Waiting...")
                    }
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
                }
                .navigationViewStyle(.stack)
                .navigationBarHidden(true)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(User())
    }
}
