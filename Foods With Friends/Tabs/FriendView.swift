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
    @State var getUid: [String: String] = [:]
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    ForEach($friendsList, id: \.self.handle) { friend in
                        NavigationLink {
                            FriendProfileView(uid: getUid[friend.handle.wrappedValue] ?? "")
                        } label: {
                            PublicUserView(user: friend)
                                .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                                .padding([.trailing, .leading], 5)
                        }
                        .buttonStyle(.plain)
                        
                    }
                    //.navigationBarHidden(true)
                    .navigationTitle("My Friends")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always))
        }
        .onAppear {
            for friend in appUser.friends {
                if friend=="" {
                    continue
                }
                UserData.getPublicUser(friend) { user in
                    friendsList.append(user)
                    getUid[user.handle] = friend
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
