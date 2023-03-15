//
//  RestaurantInfoView.swift
//  Foods With Friends
//
//  Created by Julia Zorc (student LM) on 3/14/23.
//

import SwiftUI
import struct Kingfisher.KFImage

struct RestaurantInfoView: View {
    @Binding var restaurant:Restaurant
    var body: some View {
        VStack {
            KFImage(URL(string: restaurant.logo_photos.first ?? "https://us.123rf.com/450wm/benidict83/benidict832008/benidict83200800014/benidict83200800014.jpg?ver=6"))
                .resizable()
                .frame(width: 200, height: 200, alignment: .topLeading)
            Text(restaurant.name)
                .font(.title3)
                .padding(5)
            List(restaurant.cuisines, id: \.self) { item in
                Text(item)
                    .font(.headline)
            }
            Text(restaurant.is_open ? "Open" : "Closed")
                .font(.headline)
                .foregroundColor(restaurant.is_open ? .green : .red)
            Text(restaurant.address.street_addr+" "+restaurant.address.city+", "+restaurant.address.state)
                .font(.subheadline)
                .padding(.top, 2)
                .padding(.trailing, 25)
            Spacer()
        }
    }
}

struct RestaurantInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoView(restaurant: Binding.constant(Restaurant()))
    }
}
