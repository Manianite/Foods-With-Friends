//
//  ReviewRow.swift
//  Foods With Friends
//
//  Created by Arianna Ridgeway (student LM) on 3/13/23.
//

import SwiftUI
//
//  ReviewRow.swift
//  fhZEaugi;.rS<aw
//
//  Created by Arianna Ridgeway (student LM) on 3/9/23.
//
//
//  ReviewRow.swift
//  kjdbhcwlerui
//
//  Created by Arianna Ridgeway (student LM) on 3/8/23.
//
struct ReviewRow: View {
    let review: Review
    var body: some View {
        VStack{
        HStack{
            VStack{

                Image(review.profilepic)
                    .resizable()
                    .frame(width: 50, height: 50)

                Text(review.user)
                    .font(.system(size: 15))
                    
            }
        VStack{
            Text(review.title)
                .padding(25)
            HStack{
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")

            }
            }
            Image(review.image)


            
    }
            ExpandableText(review.reviewtext , lineLimit: 2)
}
}
}
