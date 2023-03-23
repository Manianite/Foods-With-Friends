//
//  HomeView.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/4/23.

import SwiftUI
struct HomeView: View {
    @EnvironmentObject var appUser: User
    @State var testReview: Review = Review()
    @State var reviews: [Review] = []
    var body: some View {
        ScrollView {
//            ReviewView(review: $testReview)
//                .background(.white)
//                .cornerRadius(15)
//                .padding()
            ForEach($reviews) { review in
                ReviewView(review: review)
                    .background(.white)
                    .cornerRadius(15)
                    .padding(.horizontal, 10)
                    .padding(.top, 5)
            }
            .onAppear {
                UserData.observeFeed(for: appUser.uid) { gotReviews in
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



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
