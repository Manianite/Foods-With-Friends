////
////  PersonalProfileView.swift
////  Foods With Friends
////
////  Created by Julia Zorc (student LM) on 3/2/23.
////
//
//import SwiftUI
//
//struct PersonalProfileView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
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
                            .frame(width: (UIScreen.main.bounds.width)/4, height: (UIScreen.main.bounds.width)/4)
                            .clipShape(Circle())
                            .padding(.leading)
                        
                        
                        
                        Button(){
                            //edit profile
                        } label: {
                            Image(systemName: "pencil.circle.fill")
                                .foregroundColor(Color.highlight)
                                .font(.system(size: 30))
                            
                        }
                            .padding(.leading, -15.0)
                        
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
                        //username
                        Text("@juliazorc123")
                            .font(Constants.textFont)
                            .foregroundColor(Color.gray)
                    }
                    
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(Color.highlight)
                            .font(.system(size: 30))
                            .padding(.leading)
                        
                        //Location
                        Text("Wynnewood, PA")
                            .font(Constants.textFont)
                    }.padding(.leading, 1.0)
                    
                    //bio
                    Text("Hi! I am Julia and, just like you, I love food! I post reviews at least once a week. Be my friend to see my opinions and be a better informed foodie :)")
                        .font(Constants.textFontSmall)
                        .frame(width: UIScreen.main.bounds.width/2)
                        .padding(.leading)
                    
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
