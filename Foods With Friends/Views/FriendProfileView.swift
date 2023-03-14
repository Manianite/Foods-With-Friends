//
//  FriendProfileView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/14/23.
//

import SwiftUI

struct FriendProfileView: View {
    var uid: String
    @State var friend = User()
    var body: some View {
        VStack{
            HStack{
                
                VStack(alignment: .leading){
                    HStack(alignment: .bottom){
                        
                        //profile pic
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: (UIScreen.main.bounds.width)/4, height: (UIScreen.main.bounds.width)/4)
                            .clipShape(Circle())
                            .padding(.leading)
                            .onAppear {
                                UserData.getUser(uid) { user in
                                    friend = user
                                }
                            }
                        
                        
                        //Spacer()
                        
                        //# of reviews
                        VStack{
                            Text(String(friend.reviews.count))
                                .font(Constants.titleFont)
                            
                            Text("Reviews")
                                .font(Constants.textFont)
                            
                            
                        }.padding(7)
                        
                        //# of friends
                        VStack{
                            Text(String(friend.friends.count))
                                .font(Constants.titleFont)
                            
                            
                            Text("Friends")
                                .font(Constants.textFont)
                            
                        }.padding(7)
                    }
                    
                    
                    HStack{
                        //Name
                        Text(friend.username)
                            .font(Constants.titleFont)
                            .padding(.leading)
                        //username
                        Text("@\(friend.handle)")
                            .font(Constants.textFont)
                            .foregroundColor(Color.gray)
                    }
                    
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(Color.highlight)
                            .font(.system(size: 30))
                            .padding(.leading)
                        //Location
                        Text(friend.city)
                            .font(Constants.textFont)
                        Spacer()
                            .frame(width: 20)
                    }.padding(.leading, 1.0)
                    HStack {
                        //bio
                        Spacer()
                            .frame(width: 20)
                        ScrollView {
                            Text(friend.bio)
                                .font(Constants.textFontSmall)
                                .frame(width: (UIScreen.main.bounds.width)/2, height: (UIScreen.main.bounds.width)/2)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                            .frame(width: 20)
                    }
                }
                
                
            }
            
            Divider()
            Spacer()
            
        }
    }
}

struct FriendProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FriendProfileView(uid: "Julia'sAccountlessUserID")
    }
}
