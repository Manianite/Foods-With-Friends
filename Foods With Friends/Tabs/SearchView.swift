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
    
    @StateObject var data = FetchData()
    @EnvironmentObject var user: User
    @Binding var viewState: ViewState
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
                   Button{
                       try! Auth.auth().signOut()
                       user.loggedIn = false
                       viewState = .authentication
                   } label: {
                       Text("Sign Out")
                           //.font(Constants.buttonFont)
                           .frame(width: 300, height: 50)
                           .background(Color.white.opacity(0.7))
                           .cornerRadius(20)
                   }.padding()
           }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewState: Binding.constant(.login))
    }
}
