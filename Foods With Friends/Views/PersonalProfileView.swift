
//
//  PersonalProfileView.swift
//  Foods With Friends
//
//  Created by Julia Zorc (student LM) on 3/2/23.
//
import SwiftUI

struct PersonalProfileView: View {
    @EnvironmentObject var appUser: User
    @State var viewMode = true
    var body: some View {
        VStack{
            HStack{
                
                VStack(alignment: .leading){
                    HStack(alignment: .bottom){
                        
                        //profile pic
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: (UIScreen.main.bounds.width)/4, height: (UIScreen.main.bounds.width)/4)
                            .clipShape(Circle())
                            .padding(.leading)
                        
                        
                        if viewMode {
                            Button(){
                                viewMode = false
                            } label: {
                                Image(systemName: "pencil.circle.fill")
                                    .foregroundColor(Color.highlight)
                                    .font(.system(size: 30))
                            }
                                .padding(.leading, -15.0)
                        } else {
                            Button(){
                                viewMode = true
                                UserData.pushUser(appUser)
                            } label: {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color.highlight)
                                    .font(.system(size: 30))
                            }
                                .padding(.leading, -15.0)
                        }
                        //Spacer()
                        
                        //# of reviews
                        VStack{
                            Text(String(appUser.reviews.count))
                                .font(Constants.titleFont)
                            
                            Text("Reviews")
                                .font(Constants.textFont)
                            
                            
                        }.padding(7)
                        
                        //# of friends
                        VStack{
                            Text(String(appUser.friends.count))
                                .font(Constants.titleFont)
                            
                            
                            Text("Friends")
                                .font(Constants.textFont)
                            
                        }.padding(7)
                    }
                    
                    
                    HStack{
                        if viewMode {
                            //Name
                            Text(appUser.username)
                                .font(Constants.titleFont)
                                .padding(.leading)
                            //username
                            Text("@\(appUser.handle)")
                                .font(Constants.textFont)
                                .foregroundColor(Color.gray)
                        } else {
                            Spacer()
                                .frame(width: 20)
                            //Name
                            TextField("Name", text: $appUser.username)
                                .font(Constants.titleFont)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color.gray)
                                .padding(.leading, 5)
                                .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                            Spacer()
                                .frame(width: 20)
                        }
                    }
                    
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(Color.highlight)
                            .font(.system(size: 30))
                            .padding(.leading)
                        //Location
                        if viewMode {
                            Text(appUser.city)
                                .font(Constants.textFont)
                        } else {
                            TextField("City", text: $appUser.city)
                                .font(Constants.textFont)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color.gray)
                                .padding(.leading, 5)
                                .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                        }
                        Spacer()
                            .frame(width: 20)
                    }.padding(.leading, 1.0)
                    HStack {
                        //bio
                        if viewMode {
                            Spacer()
                                .frame(width: 20)
                            ScrollView {
                                Text(appUser.bio)
                                    .font(Constants.textFontSmall)
                                    .frame(width: (UIScreen.main.bounds.width)/2, height: (UIScreen.main.bounds.width)/2)
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                                .frame(width: 20)
                        } else {
                            Spacer()
                                .frame(width: 20)
                            ScrollView {
                                TextEditor(text: $appUser.bio)
                                    .font(Constants.textFontSmall)
                                    .frame(width: (UIScreen.main.bounds.width)/2, height: (UIScreen.main.bounds.width)/2)
                                    //.disableAutocorrection(true)
                                    //.autocapitalization(.none)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color.gray)
                                    .padding([.leading, .top, .bottom, .trailing], 3)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                            }
                            Spacer()
                                .frame(width: 20)
                        }
                    }
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
            .environmentObject(User())
    }
}
