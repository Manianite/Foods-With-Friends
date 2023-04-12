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
    @State var friendsList: [PublicUser] = []
    @State var friendReqsList: [PublicUser] = []
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                Color.secondarySystemBackground.edgesIgnoringSafeArea(.all)
                if friendsList.count == 0 {
                    VStack {
                        Text("You have not added any friends yet!")
                        Spacer()
                    }
                }
                ScrollView {
                    ForEach($friendReqsList, id: \.self.uid) { friend in
                        ZStack(alignment: .trailing) {
                            PublicUserView(user: friend)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(.tertiary, lineWidth: 1))
                                .padding([.trailing, .leading], 5)
                            HStack {
                                Button {
                                    UserData.remove("users/\(friend.uid.wrappedValue)/new_friends/\(appUser.uid)-O")
                                    appUser.newFriends.removeValue(forKey: friend.uid.wrappedValue+"-I")
                                    UserData.remove("users/\(appUser.uid)/new_friends/\(friend.uid.wrappedValue)-I")
                                } label: {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: (UIScreen.main.bounds.width)/8, height: (UIScreen.main.bounds.width)/8)
                                        .accentColor(.red)
                                        .padding(.trailing, 5)
                                }
                                Divider()
                                Button {
                                    UserData.setValue(true, to: "users/\(friend.uid.wrappedValue)/friends/\(appUser.uid)")
                                    UserData.remove("users/\(friend.uid.wrappedValue)/new_friends/\(appUser.uid)-O")
                                    appUser.friends[friend.uid.wrappedValue] = true
                                    appUser.newFriends.removeValue(forKey: friend.uid.wrappedValue+"-I")
                                    UserData.setValue(true, to: "users/\(appUser.uid)/friends/\(friend.uid.wrappedValue)")
                                    UserData.remove("users/\(appUser.uid)/new_friends/\(friend.uid.wrappedValue)-I")
                                    friendsList.insert(friendReqsList.first {$0==friend.wrappedValue} ?? PublicUser(), at: 0)
                                    friendReqsList.removeAll {$0==friend.wrappedValue}
                                } label: {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .frame(width: (UIScreen.main.bounds.width)/8, height: (UIScreen.main.bounds.width)/8)
                                        .accentColor(.green)
                                        .padding(.trailing, 18)
                                }
                            }
                        }
                        .padding(.bottom, -4)
                    }
                    ForEach($friendsList, id: \.self.uid) { friend in
                        NavigationLink {
                            FriendProfileView(uid: friend.uid, friendsList: $friendsList)
                        } label: {
                            PublicUserView(user: friend)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(.tertiary, lineWidth: 1))
                                .padding([.trailing, .leading], 5)
                        }
                        .buttonStyle(.plain)
                        .padding(.bottom, -5)
                    }
                }
                NavigationLink {
                    PublicUserSearchView()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: (UIScreen.main.bounds.width)/6, height: (UIScreen.main.bounds.width)/6)
                        .padding(.trailing, 10)
                        .padding(.bottom, 10)
                        .foregroundColor(.highlight)
                }
            }
            .navigationBarTitle("My Friends", displayMode: .inline)
        }
        .searchable(text: $query)
        .onAppear {
            UserData.getUser(appUser.uid) { user in
                let friendReqUids = Array(user.newFriends.keys).filter { $0.hasSuffix("-I") }.map { String($0.dropLast(2)) }
                let friendUids = Array(user.friends.keys).filter { $0 != "_" }
                friendReqsList = []
                friendsList = []
                for uid in friendReqUids {
                    UserData.getPublicUser(uid) { friendReq in
                        friendReqsList.append(friendReq)
                    }
                }
                for uid in friendUids {
                    UserData.getPublicUser(uid) { friend in
                        friendsList.append(friend)
                    }
                }
            }
        }
    }
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView()
    }
}
