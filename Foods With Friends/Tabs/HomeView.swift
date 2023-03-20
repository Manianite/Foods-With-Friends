//
//  HomeView.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/4/23.

import SwiftUI
struct HomeView: View {
    let reviews: [Review] = [
        Review(title: "LOVED IT", stars: 5, images: [""], restaurant: "The Krusty Krab", uid: "Julia'sAccountlessUserID", body: "I was sort of hesitant in visiting a restaurant underwater, but the food was beyond compare! I have never before in my whole life had a burger as delectable as the Krabby Paddy. Thanks, @Patrick!")
    ]
    
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    @State private var shrinkText: String
    private var text: String
    let font: UIFont
    let lineLimit: Int
    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            return self.expanded ? " read less" : " ... read more"
        }
    }
    
    init(_ text: String, lineLimit: Int, font: UIFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)) {
        self.text = text
        self.lineLimit = lineLimit
        _shrinkText =  State(wrappedValue: text)
        self.font = font
    }
    var body: some View {
        VStack{
            NavigationView {
                List(reviews) { review in
                    ReviewRow(review: review)
                }
            }
        }
    }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView("", lineLimit: 10)
    }
}
