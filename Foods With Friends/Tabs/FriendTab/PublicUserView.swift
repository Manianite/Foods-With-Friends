//
//  PublicUserView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/13/23.
//

import SwiftUI
import struct Kingfisher.KFImage

struct PublicUserView: View {
    @ObservedObject var user: PublicUser = PublicUser(username: "", handle: "", uid: "")
    @Binding var uid: String
    var body: some View {
        ZStack {
            HStack {
                KFImage(URL(string: user.profilePic))
                    .resizable()
                    .frame(width: (UIScreen.main.bounds.width)/6, height: (UIScreen.main.bounds.width)/6)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .padding(5)
                VStack {
                    Text(user.username)
                        .font(Constants.titleFont)
                    Text("@"+user.handle)
                        .font(Constants.textFont)
                        .foregroundColor(.gray)
                }
                Color.white
                    .padding(10)
            }
        }
        .onAppear {
            user.username = "Loading..."
            UserData.getPublicUser(uid) { gotUser in
                user.reinit(gotUser)
            }
        }
        .onChange(of: user) { newUser in
            UserData.getPublicUser(uid) { gotUser in
                newUser.reinit(gotUser)
            }
        }
    }
}

struct PublicUserView_Previews: PreviewProvider {
    static var previews: some View {
        PublicUserView(uid: Binding.constant("Julia'sAccountlessUserID"))
    }
}
