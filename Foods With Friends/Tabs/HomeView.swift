//
//  HomeView.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/4/23.

import SwiftUI
struct HomeView: View {
    @State var reviews: [Review] = [
        Review()
    ]
    var body: some View {
        ScrollView {
            ForEach($reviews) { review in
                ReviewView(review: review)
                    .background(.white)
                    .cornerRadius(15)
                    .padding()
            }
            .background(Color.secondarySystemBackground)
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
