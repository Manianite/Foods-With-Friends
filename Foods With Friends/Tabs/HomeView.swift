//
//  HomeView.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/4/23.
//
//
//  HomeView.swift
//  fhZEaugi;.rS<aw
//
//  Created by Arianna Ridgeway (student LM) on 3/9/23.
//
//
//  HomeView.swift
//  kjdbhcwlerui
//
//  Created by Arianna Ridgeway (student LM) on 3/8/23.
//

import SwiftUI
struct HomeView: View {
    let reviews: [Review] = [
        Review(title: "TITLE", stars: 5, images: [], restaurant: "It's Me", uid: "", body: "aAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
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
