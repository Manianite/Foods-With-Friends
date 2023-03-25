//
//  GroupView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/23/23.
//

import SwiftUI

struct GroupView: View {
    @EnvironmentObject var appUser: User
    @Binding var group: FoodGroup
    @State var reviews: [Review] = []
    var body: some View {
        VStack {
            Text(group.name)
                .font(Constants.titleFont)
            Text("\(group.members.count) members")
                .font(Constants.textFontSmall)
            ScrollView {
                ForEach($reviews) { review in
                    ReviewView(review: review)
                        .background(.white)
                        .cornerRadius(15)
                        .padding(.horizontal, 10)
                        .padding(.top, 5)
                }
                .onAppear {
                    UserData.observeFeed(for: "groups/\(group.gid)/\(appUser.uid)/feed") { gotReviews in
                        reviews = Array(gotReviews.values)
                    }
                }
                .onDisappear {
                    UserData.stopObservingFeed()
                }
            }
            .background(Color.secondarySystemBackground)
        }
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(group: .constant(FoodGroup()))
    }
}
