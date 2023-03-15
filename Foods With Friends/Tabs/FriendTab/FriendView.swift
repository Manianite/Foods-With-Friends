//
//  FriendView.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/7/23.
//

import SwiftUI

struct FriendView: View {
    @EnvironmentObject var appUser: User
    @State var query = ""
    @State var friendsList: [String] = []
    @State var friendReqsList: [String] = []
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    ForEach($friendReqsList, id: \.self) { friendID in
                        ZStack(alignment: .trailing) {
                            PublicUserView(uid: friendID)
                                .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(.black))
                                .padding([.trailing, .leading], 5)
                            Button {
                                UserData.setValue(true, to: "users/\(friendID.wrappedValue)/friends/\(appUser.uid)")
                                UserData.remove("users/\(friendID.wrappedValue)/new_friends/\(appUser.uid)-O")
                                appUser.friends[friendID.wrappedValue] = true
                                appUser.newFriends.removeValue(forKey: friendID.wrappedValue+"-I")
                                UserData.setValue(true, to: "users/\(appUser.uid)/friends/\(friendID.wrappedValue)")
                                UserData.remove("users/\(appUser.uid)/new_friends/\(friendID.wrappedValue)-I")
                            } label: {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: (UIScreen.main.bounds.width)/7, height: (UIScreen.main.bounds.width)/7)
                                    .accentColor(.highlight)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                    ForEach($friendsList, id: \.self) { friend in
                        NavigationLink {
                            FriendProfileView(uid: friend)
                        } label: {
                            PublicUserView(uid: friend)
                                .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(.black))
                                .padding([.trailing, .leading], 5)
                        }
                        .buttonStyle(.plain)
                        
                    }
                    .navigationTitle("My Friends")
                    .navigationBarTitleDisplayMode(.inline)
                }
                NavigationLink {
                    PublicUserSearchView()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: (UIScreen.main.bounds.width)/6, height: (UIScreen.main.bounds.width)/6)
                        .padding(.trailing, 10)
                        .padding(.bottom, 3)
                        .foregroundColor(.highlight)
                }
            }
        }
        .searchable(text: $query)
        .onAppear {
            UserData.observeUser(for: appUser.uid) { user in
                friendReqsList = Array(user.newFriends.keys).filter { $0.hasSuffix("-I") }.map { String($0.dropLast(2)) }
                friendsList = Array(user.friends.keys).filter { $0 != "_" }
            }
            //reload view
        }
        .onDisappear {
            UserData.stopObservingUser()
        }
    }
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView()
    }
}
