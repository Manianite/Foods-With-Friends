//
//  RestaurantReviewsView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 4/20/23.
//

import SwiftUI

struct RestaurantReviewsView: View {
    @Binding var reviews: [Review]
    var body: some View {
        VStack {
            if(reviews.count == 0){
                VStack{
                    Text("None of your friends have reviewed this restaurant yet. Leave a post and be the first!")
                        .font(Constants.textFont)
                        .foregroundColor(Color.black)
                        .padding(10)
                    Spacer()
                }
            }
            
            ForEach(Array(Set(reviews))) { review in
                ReviewView(review: .constant(review))
                    .background(.white)
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(.tertiary, lineWidth: 1))
                    .padding(.horizontal, 10)
                    .padding(.top, 5)
            }
            Spacer()
        }
        .background(Color.secondarySystemBackground)
    }
}

//struct RestaurantReviewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantReviewsView()
//    }
//}
