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
    @State var users: [PublicUser] =  []
    @State var filteredUsers: [PublicUser] = []
    var body: some View {
        ScrollView {
            ForEach($filteredUsers, id: \.self.uid) { user in
                ZStack(alignment: .trailing) {
                    PublicUserView(user: user)
                        .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(.black))
                        .padding([.trailing, .leading], 5)
                    Button {
                        UserData.setValue(true, to: "users/\(user.uid.wrappedValue)/new_friends/\(appUser.uid)-I")
                        appUser.newFriends[user.uid.wrappedValue+"-O"] = true
                        UserData.setValue(true, to: "users/\(appUser.uid)/new_friends/\(user.uid.wrappedValue)-O")
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width)/7, height: (UIScreen.main.bounds.width)/7)
                            .accentColor(.highlight)
                            .padding(.trailing, 15)
                    }
                    .disabled(appUser.newFriends.keys.contains(user.uid.wrappedValue+"-O") )
                }
            }
            .navigationTitle("Search Users")
        }
        .searchable(text: $query)
        .onAppear {
            UserData.getBranch(from: "users/user_dict", as: [String: PublicUser].self) { userList in
                users = Array(userList.values).filter { user in
                    !appUser.friends.keys.contains(user.uid) && appUser.uid != user.uid
                }
                filteredUsers = users
            }
        }
        .onChange(of: query) { newValue in
            let filtering = users.filter { $0.handle.lowercased().contains(query.lowercased()) || $0.username.lowercased().contains(query.lowercased()) }
            if !filtering.containsSameElements(as: filteredUsers) {
                filteredUsers = filtering
            }
        }
    }
}

struct PublicUserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PublicUserSearchView()
    }
}
