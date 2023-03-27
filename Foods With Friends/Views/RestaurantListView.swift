//
//  RestaurantListView.swift
//  Foods With Friends
//
//  Created by Julia Zorc (student LM) on 3/14/23.
//

import SwiftUI
import struct Kingfisher.KFImage
import Combine

struct RestaurantListView: View {
    @Binding var restaurant: Restaurant
    var body: some View {
        HStack(alignment: .top) {
            HStack {
                KFImage(URL(string: restaurant.logo_photos.first ?? "https://us.123rf.com/450wm/benidict83/benidict832008/benidict83200800014/benidict83200800014.jpg?ver=6"))
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .topLeading)
                    .cornerRadius(20)
                    .padding(5)
            }
            VStack(alignment: .trailing) {
                Text(restaurant.name)
                    .font(.title3)
                    .padding(5)
                HStack {
                    Spacer()
                    Text(restaurant.cuisines.first ?? "Food Place")
                        .font(.headline)
                    Spacer()
                    Text(restaurant.is_open ? "Open" : "Closed")
                        .font(.headline)
                        .foregroundColor(restaurant.is_open ? .green : .red)
                    Spacer()
                }
            }
        }
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView(restaurant: Binding.constant(Restaurant()))
    }
}
