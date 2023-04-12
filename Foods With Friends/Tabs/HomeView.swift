//
//  HomeView.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/4/23.

import SwiftUI
struct HomeView: View {
    @EnvironmentObject var appUser: User
    @State var reviews: [Review] = []

    var body: some View {
        ScrollView {
            if reviews.count == 0 {
                VStack {
                    Text("You do not have a feed yet! Add some friends, join some local groups, and have a good time!")
                    Spacer()
                }
            }
            ForEach($reviews) { review in
                ReviewView(review: review)
                    .background(.white)
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(.tertiary, lineWidth: 1))
                    .padding(.horizontal, 10)
                    .padding(.top, 5)
            }
        }
        .onAppear {
            UserData.observeFeed(for: "feeds/\(appUser.uid)") { gotReviews in
                reviews = Array(gotReviews.values)
            }
        }
        .onDisappear {
            UserData.stopObservingFeed()
        }
        .background(Color.secondarySystemBackground)
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()

    }
}
