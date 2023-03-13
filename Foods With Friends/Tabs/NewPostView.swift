//
//  NewPostView.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/7/23.
//

import SwiftUI
//
//  NewPostView.swift
//  fhZEaugi;.rS<aw
//
//  Created by Arianna Ridgeway (student LM) on 3/9/23.
//

struct NewPostView: View {
    @State var reviewtext: String
    var image: String
    @State var title: String
    @State var ratinga: Float = 5.0
    
   
    
    var body: some View {
        
        VStack{
            
        
//        if stars == "5" {
//            ratinga = 5.0
//        }
//        if stars == "4" {
//            ratinga = 4.0
//        }
//        if stars == "3" {
//            ratinga = 3.0
//        }
//        if stars == "2" {
//            ratinga = 2.0
//        }
//        if stars == "1" {
//            ratinga = 1.0
//        }
            
//            TextField(
//                    "Stars",
//                    text: $stars                )
//            .padding()
        TextField(
                "Title",
                text: $title
            )
        .padding()

        TextField(
                "Review",
                text: $reviewtext
            )
        .padding()
            VStack{
            HStack{
                VStack{

                    Image("profile")
                        .resizable()
                        .frame(width: 50, height: 50)

                    Text("meeee")
                        .font(.system(size: 15))
                        
                }
            VStack{
                Text(title)
                    .padding(25)
                HStack{
                    // iterate from i = 1 to i = 3
                    
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")

                }
                }
                
                Image("taco")
                    .resizable()
                    .frame(width: 100, height: 100)


                
        }
                ExpandableText(reviewtext , lineLimit: 1)
    }
            }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(reviewtext: "", image: "", title: "")
    }
}
