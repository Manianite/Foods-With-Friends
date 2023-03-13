//
//  StarsView.swift
//  Foods With Friends
//
//  Created by Arianna Ridgeway (student LM) on 3/13/23.
//
//
//  StarsView.swift
//  fhZEaugi;.rS<aw
//
//  Created by Arianna Ridgeway (student LM) on 3/9/23.
//

import SwiftUI

struct StarsView: View {
    static let COLOR = Color.orange
    @State var star1: String = "star"
    @State var star2: String = "star"
    @State var star3: String = "star"
    @State var star4: String = "star"
    @State var star5: String = "star"
    @State var numstars: Int = 0
    @State var stars: String = ""

  var body: some View {
      HStack{
  Button {
      if star1 == "star"{
          star1 = "star.fill"
          numstars += 1
      }
      else if star1 == "star.fill"{
          star1 = "star"
          numstars -= 1
      }
    
  }label: {
      Image(systemName: star1)
          .foregroundColor(StarsView.COLOR)
  }
  Button {
      if star2 == "star"{
          star2 = "star.fill"
          numstars += 1
      }
      else if star2 == "star.fill"{
          star2 = "star"
          numstars -= 1
      }
  }label: {
  Image(systemName: star2)
          .foregroundColor(StarsView.COLOR)
          }
  Button {
      if star3 == "star"{
          star3 = "star.fill"
          numstars += 1
      }
      else if star3 == "star.fill"{
          star3 = "star"
          numstars -= 1
      }
  }label: {
  Image(systemName: star3)
          .foregroundColor(StarsView.COLOR)
          }
      
  Button {
      if star4 == "star"{
          star4 = "star.fill"
          numstars += 1
      }
      else if star4 == "star.fill"{
          star4 = "star"
          numstars -= 1
      }
  }label: {
  Image(systemName: star4)
          .foregroundColor(StarsView.COLOR)
      }
  Button {
      if star5 == "star"{
          star5 = "star.fill"
          numstars += 1
      }
      else if star5 == "star.fill"{
          star5 = "star"
          numstars -= 1
      }
  }label: {
  Image(systemName: star5)
          .foregroundColor(StarsView.COLOR)
          }
          }
//
//  private var halfFullStar: some View {

//  private var emptyStar: some View {
//    Image(systemName: "star").foregroundColor(StarsView.COLOR)
//  }


}
}
