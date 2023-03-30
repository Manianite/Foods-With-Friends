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
            
            Group{
                VStack{
                    HStack(alignment: .top){
                        Text("Post")
                            .foregroundColor(Color.white)
                            .padding(.leading, 10)
                        Spacer()
                        KFImage(URL(string: restaurant.logo_photos.first ?? "https://us.123rf.com/450wm/benidict83/benidict832008/benidict83200800014/benidict83200800014.jpg?ver=6"))
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .topLeading)
                        Spacer()
                        
                        Button{
                            //
                        }label: {
                            Text("Post")
                                .padding(.trailing, 10)
                        }
                    }
                    Text(restaurant.name)
                        .font(Constants.titleFont)
                        .foregroundColor(Color.highlight)
                        .padding(5)
                        .scaledToFill()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
            }.frame(height: UIScreen.screenHeight/4.5)
            
            List(restaurant.cuisines, id: \.self) { item in
                Text(item)
                    .font(Constants.textFont)
                
            }.listStyle(.plain)
            
            
            VStack{
            Text(restaurant.is_open ? "Open" : "Closed")
                .font(Constants.textFont)
                .foregroundColor(restaurant.is_open ? .green : Color.highlight)
            Text(restaurant.address.street_addr+" "+restaurant.address.city+", "+restaurant.address.state)
                .font(Constants.textFont)
                .padding(.top, 2)
                .padding(.bottom, 7)
                .padding(.trailing, 25)
                .multilineTextAlignment(.center)
            }
            //Spacer()
        }
    }
}

struct RestaurantInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoView(restaurant: Binding.constant(Restaurant()))
    }
}
