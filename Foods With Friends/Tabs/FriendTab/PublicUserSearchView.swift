//
//  PublicUserSearchView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/14/23.
//

import SwiftUI

struct PublicUserSearchView: View {
    @State var query = ""
    @EnvironmentObject var appUser: User
    @State var users: [String] =  []
    var body: some View {
        ScrollView {
            ForEach($users, id: \.self) { user in
                ZStack(alignment: .trailing) {
                    PublicUserView(uid: user)
                        .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(.black))
                        .padding([.trailing, .leading], 5)
                    Button {
                        UserData.setValue(true, to: "users/\(user.wrappedValue)/new_friends/\(appUser.uid)-I")
                        appUser.newFriends[user.wrappedValue+"-O"] = true
                        UserData.setValue(true, to: "users/\(appUser.uid)/new_friends/\(user.wrappedValue)-O")
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width)/7, height: (UIScreen.main.bounds.width)/7)
                            .accentColor(.highlight)
                            .padding(.trailing, 15)
                    }
                    .disabled(appUser.newFriends.keys.contains(user.wrappedValue+"-O") )
                }
            }
        }
        .searchable(text: $query)
        .onAppear {
            UserData.getBranch(from: "users/user_dict", as: [String: PublicUser].self) { userList in
                users = Array(userList.values).filter { user in
                    !appUser.friends.keys.contains(user.uid) && appUser.uid != user.uid
                }.map { $0.uid }
            }
        }
    }
}

struct PublicUserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PublicUserSearchView()
    }
}
