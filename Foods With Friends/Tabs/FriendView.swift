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
    var body: some View {
        VStack {
            TextField("Search", text: $query)
                .padding(.leading, 5)
                .background(.gray.opacity(0.5))
                .foregroundColor(.black)
                .font(Constants.textFontSmall)
                .cornerRadius(10)
            ForEach($friendsList, id: \.self.handle) { friend in
                PublicUserView(user: friend)
            }
        }
        .onAppear {
            for friend in appUser.friends {
                if friend=="" {
                    continue
                }
                UserData.getPublicUser(appUser.uid) { user in
                    friendsList.append(user)
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
