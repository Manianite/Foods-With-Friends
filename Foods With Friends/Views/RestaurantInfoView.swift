//
//  RestaurantInfoView.swift
//  Foods With Friends
//
//  Created by Julia Zorc (student LM) on 3/14/23.
//

import SwiftUI
import struct Kingfisher.KFImage

struct RestaurantInfoView: View {
    @Binding var restaurant: Restaurant
   // @State var showNewPostView: Bool = false
   // @Binding var selectedTab: Tabs
    var body: some View {
        
        ScrollView {
            //ScrollView{
            Group{
                VStack{
                    HStack{
                        Spacer()
                        
                    }
                    
                    //HStack(alignment: .top){
                    //                        Text("Post")
                    //                            .foregroundColor(Color.white)
                    //                            .padding(.leading, 10)
                    Spacer()
                    KFImage(URL(string: restaurant.logo_photos.first ?? "https://us.123rf.com/450wm/benidict83/benidict832008/benidict83200800014/benidict83200800014.jpg?ver=6"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, alignment: .center)
                        .clipped()
                    //   Spacer()
                    //  }
                    HStack(alignment: .center){
                        Text(restaurant.name)
                            .font(Constants.titleFont.bold())
                        //     .foregroundColor(Color.highlight)
                            .padding(.leading)
                            .padding(.top, 5)
                            .scaledToFill()
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                        Spacer()
                        Spacer()
                        Text(restaurant.is_open ? "Open" : "Closed")
                            .font(Constants.textFont)
                            .foregroundColor(restaurant.is_open ? .green : Color.highlight)
                            .padding(.trailing, 15)
                            .padding(.top, 5)
                        
                    }
                    HStack{
                        Text("\(restaurant.address.street_addr) \(restaurant.address.city), \(restaurant.address.state)")
                            .font(Constants.textFont)
                            .foregroundColor(Color.gray)
                            .padding([.bottom, .leading])
                        Spacer()
                    }
                    Spacer()
                }
            }//.frame(height: UIScreen.screenHeight/4.5)
            
            //Group{
            HStack{
                Text("Available Cuisines:")
                    .font(Constants.textFont.bold())
                    .padding(.leading)
                    .padding(.bottom, -5)
                Spacer()
            }
            ForEach(restaurant.cuisines, id: \.self) { item in
                VStack{
                    Divider()
                    HStack{
                        Text(item)
                            .font(Constants.textFont)
                            .padding([.top, .bottom], 5)
                            .padding(.leading)
                        Spacer()
                        
                    }
                }
                
            }.listStyle(.plain)
            Divider()
            
        }
        HStack{
            Button{
              //  showNewPostView = true
            }label: {
                Text("Review Restaurant")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 180, height: 50)
                    .background(Color.highlight)
                    .cornerRadius(15.0)
            }.padding([.bottom, .leading], 10)
            NavigationLink{
                
            }label: {
                Text("See Reviews")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 180, height: 50)
                    .background(Color.highlight)
                    .cornerRadius(15.0)
            }.padding([.bottom, .trailing], 10)
        }
        //}
//        .sheet(isPresented: $showNewPostView) {
//            NewPostView(selectedTab: $selectedTab)
//        }
    //}
    //Spacer()
}
}

struct RestaurantInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoView(restaurant: Binding.constant(Restaurant())
                           //, selectedTab: .constant(.NewPostView)
        )
    }
}
