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
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(20)
                    .padding(.trailing, 13)
            }
            VStack(alignment: .trailing) {
                Text(restaurant.name)
                    .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                    .foregroundColor(Color.black)
                    .font(Constants.titleFont)
                    .padding(.top, 10)
                    .padding(.trailing, 2)
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                Text("\(restaurant.address.city), \(restaurant.address.state)")
                    .foregroundColor(Color.gray)
                    .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                    .font(Constants.titleFont)
                    .padding(.bottom, 10)
                    .padding(.trailing, 2)
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                HStack {
                    Spacer()
                    Text(restaurant.cuisines.first ?? "Restaurant")
                        .font(Constants.textFont)
                        .foregroundColor(Color.black)
                    Spacer()
                    Text(restaurant.is_open ? "Open" : "Closed")
                        .font(Constants.textFont)
                        .foregroundColor(restaurant.is_open ? .green : Color.highlight)
                        .padding(.trailing, 5)
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
