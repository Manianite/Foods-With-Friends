//
//  PublicUserView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/13/23.
//

import SwiftUI
import struct Kingfisher.KFImage

struct PublicUserView: View {
    @Binding var user: PublicUser
    var body: some View {
        ZStack {
            HStack {
                KFImage(URL(string: user.profilePic))
                    .placeholder {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .resizable()
                    .frame(width: (UIScreen.main.bounds.width)/6, height: (UIScreen.main.bounds.width)/6)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(5)
                VStack(alignment: .leading) {
                    Text(user.username)
                        .font(Constants.titleFont)
                        .lineLimit(1)
                    Text("@"+user.handle)
                        .font(Constants.textFont)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
//        .onAppear {
//            user.username = "Loading..."
//            UserData.getPublicUser(uid) { gotUser in
//                user.reinit(gotUser)
//            }
//        }
//        .onChange(of: user) { newUser in
//            UserData.getPublicUser(uid) { gotUser in
//                newUser.reinit(gotUser)
//            }
//        }
    }
}

struct PublicUserView_Previews: PreviewProvider {
    static var previews: some View {
        PublicUserView(user: Binding.constant(PublicUser()))
    }
}
