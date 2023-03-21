//
//  HomeView.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/4/23.

import SwiftUI
struct HomeView: View {
    @State var reviews: [Review] = [
        Review(),
        Review(),
        Review()
    ]
    var body: some View {
        VStack {
            List($reviews) { review in
                ReviewView(review: review) //i can't figure out how to make this look good
            }
        }
    }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
