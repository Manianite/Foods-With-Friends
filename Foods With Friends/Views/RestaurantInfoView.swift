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
    @State var chosen: Restaurant?
    @State var reviews: [Review] = []
    @Binding var selectedTab: Tabs
    @EnvironmentObject var appUser: User
    
    var body: some View {
        
        ScrollView {
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
                chosen = restaurant
                print(chosen!.name)
                selectedTab = .NewPostView
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
                if(reviews.count <= 0){
                    VStack{
                        Text("None of your friends have reviewed this restaurant yet. Leave a post and be the first!")
                            .font(Constants.textFont)
                            .foregroundColor(Color.black)
                            .padding(10)
                        Spacer()
                    }
                }
                
                ForEach($reviews) { review in
                    ReviewView(review: review)
                        .background(.white)
                        .cornerRadius(15)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(.tertiary, lineWidth: 1))
                        .padding(.horizontal, 10)
                        .padding(.top, 5)
                }
                .onAppear {
    //                UserData.observeFeed(for: "feeds/\(appUser.uid)") { gotReviews in
    //                    reviews = Array(gotReviews.values).filter {$0.restaurant = restaurant.name}
    //                }
                    UserData.getBranch(from: "feeds/\(appUser.uid)", as: [String: Review].self) { gotReviews in
                        reviews = Array(gotReviews.values).filter {$0.restaurant == restaurant.name}
                    }
                    UserData.getBranch(from: "users/\(appUser.uid)/groups", as: [String: String].self) { gotGroups in
                        for group in gotGroups {
                            UserData.getBranch(from: "groups/\(group.key)/feed", as: [String: Review].self) { gotReviews in
                                reviews += Array(gotReviews.values).filter {$0.restaurant == restaurant.name}
                            }
                        }
                    }
                }
                .onDisappear {
                    UserData.stopObservingFeed()
                }
                .background(Color.secondarySystemBackground)
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
        RestaurantInfoView(restaurant: Binding.constant(Restaurant()), selectedTab: .constant(.SearchView))
            .environmentObject(User())
    }
}
