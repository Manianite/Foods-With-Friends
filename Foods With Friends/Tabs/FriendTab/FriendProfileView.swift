//
//  FriendProfileView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/14/23.
//

import SwiftUI
import struct Kingfisher.KFImage


struct FriendProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appUser: User
    @Binding var uid: String
    @Binding var friendsList: [PublicUser]
    @ObservedObject var friend = User()
    @State var unfriendAssurance = false
    var body: some View {
        VStack{
            HStack{
                
                VStack(alignment: .leading) {
                    HStack(alignment: .bottom) {
                        
                        //profile pic
                        KFImage(URL(string: friend.profilePic))
                            .placeholder {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: (UIScreen.main.bounds.width)/4, height: (UIScreen.main.bounds.width)/4)
                            .clipShape(Circle())
                            .padding(.leading, 25)
                            .padding(.bottom, 5)
                            .onAppear {
                                UserData.getUser(uid) { user in
                                    friend.reinit(user)
                                }
                            }
                        Button {
                            unfriendAssurance.toggle()
                        } label: {
                            Image(systemName: "person.badge.minus.fill")
                                .foregroundColor(Color.highlight)
                                .font(.system(size: 30))
                        }
                        .padding(.leading, -15.0)
                        Spacer()
                        
                        //# of reviews
                        VStack{
                            Text(String(friend.reviews.count-1))
                                .font(Constants.titleFont)
                            Text("Reviews")
                                .font(Constants.textFont)
                                .frame(width: UIScreen.screenWidth/4)
                        }.padding(.leading, 20)
                        
                        //# of friends
                        VStack{
                            Text(String(friend.friends.count-1))
                                .font(Constants.titleFont)
                            
                            Text("Friends")
                                .font(Constants.textFont)
                                .frame(width: UIScreen.screenWidth/4)
                            
                        }
                        .padding(.trailing, 20)
   
                    }
                    .frame(width: UIScreen.screenWidth-30)
                    
                    
                    HStack{
                        //Name
                        Text(friend.username)
                            .font(Constants.titleFont)
                            .padding(.leading)
                        //username
                        Text("@\(friend.handle)")
                            .font(Constants.textFont)
                            .foregroundColor(Color.highlight.opacity(1))
                    }
    
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(Color.highlight)
                            .font(.system(size: 20))
                            .padding(.leading, 15)
                        //Location
                        Text(friend.city)
                            .font(Constants.textFont)
                        Spacer()
                            .frame(width: 15)
                    }.padding(.leading, 1.0)
                    
                    HStack {
                        //bio
                        ScrollView {
                            Text(friend.bio)
                                .font(Constants.textFontSmall)
                                .frame(width: (UIScreen.main.bounds.width)-20, height: (UIScreen.main.bounds.width)/6)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                            Spacer()
                        }
                    }
                }
            }
            
            Divider()
            Spacer()
            
        }
        .alert(isPresented: $unfriendAssurance) {
            Alert (
                title: Text("Foods With Friends"),
                message: Text("Are you sure you want to unfriend \(friend.username)?"),
                primaryButton: .destructive(Text("Unfriend")) {
                    UserData.remove("users/\(friend.uid)/friends/\(appUser.uid)")
                    appUser.friends.removeValue(forKey: friend.uid)
                    UserData.remove("users/\(appUser.uid)/friends/\(friend.uid)")
                    friendsList.removeAll {$0.uid == friend.uid}
                    self.presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct FriendProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FriendProfileView(uid: Binding.constant("Julia'sAccountlessUserID"), friendsList: Binding.constant([]))
    }
}
