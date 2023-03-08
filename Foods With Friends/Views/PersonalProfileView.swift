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
            HStack(){
                Spacer()
            
            }
            
            HStack{
                
                VStack(alignment: .leading){
                    HStack(alignment: .bottom){
                    
                    //profile pic
                    Image("profileDefault")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.leading)
                        
                       
                        
                        Button(){
                            //edit profile
                        } label: {
                            Image(systemName: "pencil")
                                .foregroundColor(Color.black)
                                .font(.system(size: 30))
                            
                        }.padding(0.25)
                        
                        Spacer()
                        
                        //# of reviews
                        VStack{
                            
                            Text("123")
                                .font(Constants.titleFont)
                            
                            
                            Text("Reviews")
                                .font(Constants.textFont)
                            
                            
                        }.padding()
                        
                        //# of friends
                        VStack{
                            Text("78")
                                .font(Constants.titleFont)
                            
                            
                            Text("Friends")
                                .font(Constants.textFont)
                            
                        }.padding()
                    }
                    
                    
                    HStack{
                        //Name
                        Text("Julia Zorc")
                            .font(Constants.titleFont)
                            .padding(.leading)
                            .padding([.top, .bottom, .leading], 0.25)
                        //username
                        Text("@juliazorc123")
                            .font(Constants.textFont)
                            .foregroundColor(Color.highlight)
                            .padding(0.25)
                    }
                    //Location
                    Text("Wynnewood")
                        .font(Constants.textFont)
                        .padding(.leading)
                        .padding([.top, .bottom, .leading], 0.25)
                    
                    //bio
                    Text("Hi! I am Julia and, just like you, I love food! I post reviews at least once a week. Be my friend to see my opinions and be a better informed foodie :)")
                        .font(Constants.textFontSmall)
                        .frame(width: 200)
                        .padding(.leading)
                        .padding([.top, .bottom, .leading], 0.25)
                    
                }
                
                
            }
            
            Divider()
            Spacer()
            
        }
    }
    
}

struct PersonalProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalProfileView()
    }
}
