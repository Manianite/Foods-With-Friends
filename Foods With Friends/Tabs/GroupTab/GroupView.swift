//
//  GroupView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/23/23.
//

import SwiftUI

struct GroupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appUser: User
    @Binding var group: FoodGroup
    @Binding var groupsList: [FoodGroup]
    @Binding var insideNavigator: Bool
    @State var reviews: [Review] = []
    var body: some View {
        VStack {
            Text(group.name)
                .font(Constants.titleFont)
            Text("\(group.members.count) members")
                .font(Constants.textFontSmall)
            Divider()
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
        }
        .background(Color.secondarySystemBackground)
        .navigationBarItems(trailing: group.gid==appUser.uid ? AnyView(NavigationLink("Edit", isActive: $insideNavigator) {EditGroupView(group, groups: $groupsList, isActive: $insideNavigator)}) : AnyView(EmptyView()))
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(group: .constant(FoodGroup()), groupsList: .constant([]), insideNavigator: .constant(false))
    }
}
