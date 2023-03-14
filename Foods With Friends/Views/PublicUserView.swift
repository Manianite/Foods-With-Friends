//
//  PublicUserView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/13/23.
//

import SwiftUI

struct PublicUserView: View {
    @Binding var user: PublicUser
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: user.profilePic)
                    .resizable()
                    .frame(width: (UIScreen.main.bounds.width)/6, height: (UIScreen.main.bounds.width)/6)
                    .aspectRatio(contentMode: .fit)
                VStack {
                    Text(user.username)
                        .font(Constants.titleFont)
                    Text("@"+user.handle)
                        .font(Constants.textFont)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
    }
}

struct PublicUserView_Previews: PreviewProvider {
    static var previews: some View {
        PublicUserView(user: Binding.constant(PublicUser()))
    }
}
