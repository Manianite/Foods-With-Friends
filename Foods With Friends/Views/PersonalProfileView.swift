//
//  PersonalProfileView.swift
//  Foods With Friends
//
//  Created by Julia Zorc (student LM) on 3/2/23.
//

import SwiftUI

struct PersonalProfileView: View {
    var body: some View {
        VStack{
            HStack{
                
                VStack{
                    //profile pic
                    Image("profileDefault")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    //    .frame(width: (UIScreen.width)/4)
                        .clipShape(Circle())

                    
                    //location
                    Text("Wynnewood, PA")
                        .font(Constants.textFont)
                    
                    //bio
                    Text("Hi! I am Julia and, just like you, I love food! I post reviews at least once a week. Be my friend to see my opinions and be a better informed foodie :)")
                        .font(Constants.textFont)
                    
                }
                
                Spacer()
                
                VStack{
                    HStack{
                        //Name
                        Text("Julia Zorc")
                            .font(Constants.titleFont)
                        
                        Spacer()
                        
                        //username
                        Text("@juliazorc123")
                            .font(Constants.textFont)
                            .foregroundColor(Color.highlight)
                        
                    }
                    
                    //# of reviews
                    VStack{
                        Text("123")
                            .font(Constants.titleFont)
                        
                        Text("Reviews")
                            .font(Constants.textFont)
                        
                    }
                    
                    //# of friends
                    VStack{
                        Text("78")
                            .font(Constants.titleFont)
                        
                        Text("Friends")
                            .font(Constants.textFont)
                        
                    }
                    
                }
            }
            
            
            Spacer()
            
        }
    }
    
}

struct PersonalProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalProfileView()
    }
}
