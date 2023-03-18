
//
//  PersonalProfileView.swift
//  Foods With Friends
//
//  Created by Julia Zorc (student LM) on 3/2/23.
//
import SwiftUI
import struct Kingfisher.KFImage

struct PersonalProfileView: View {
    @EnvironmentObject var appUser: User
    @State var viewMode = true
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    var body: some View {
        
        
        VStack(alignment: .leading){
            HStack{
                Spacer()
                HStack(alignment: .bottom){
                    Spacer()
                    if viewMode {
                        //profile pic
                        KFImage(URL(string: appUser.profilePic))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: (UIScreen.main.bounds.width)/4, height: (UIScreen.main.bounds.width)/4)
                            .clipShape(Circle())
                            .padding(.leading, 8)
                        
                        Button {
                            viewMode = false
                        } label: {
                            Image(systemName: "pencil.circle.fill")
                                .foregroundColor(Color.highlight)
                                .font(.system(size: 30))
                        }
                        .padding(.leading, -20.0)
                    } else {
                        Button {
                            showingImagePicker = true
                        } label: {
                            //profile pic
                            ZStack(alignment: .bottom){
                                KFImage(URL(string: appUser.profilePic))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: (UIScreen.main.bounds.width)/4, height: (UIScreen.main.bounds.width)/4)
                                    .clipShape(Circle())
                                    .padding(.leading, 8)
                                
                                Text("Edit")

                                    .padding(.horizontal, 5)
                                    .background(Color.highlight.opacity(1))
                                    .cornerRadius(40)
                                    .frame(width: (UIScreen.main.bounds.width)/5, height: (UIScreen.main.bounds.width)/4)
                                    .foregroundColor(Color.white)
                                    .font(Constants.textFontSmall)
                                    .font(.system(size: 30))
                                    .padding(.leading, 8)
                            }
                        }
                        
                        Button {
                            viewMode = true
                            UserData.pushUser(appUser)
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color.highlight)
                                .font(.system(size: 30))
                        }
                        .padding(.leading, -20.0)
                    }
                    Spacer()
                    
                    //# of reviews
                    VStack{
                        Text(String(appUser.reviews.count))
                            .font(Constants.titleFont)
                        
                        Text("Reviews")
                            .font(Constants.textFont)
                            .frame(width: UIScreen.screenWidth/5)
                            .scaledToFill()
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                        
                        
                    }
                    
                    //# of friends
                    VStack{
                        Text(String(appUser.friends.count))
                            .font(Constants.titleFont)
                        
                        
                        Text("Friends")
                            .font(Constants.textFont)
                            .frame(width: UIScreen.screenWidth/5)
                            .scaledToFill()
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                    Spacer()
                }.frame(width: UIScreen.screenWidth)
                Spacer()
            }
            
            HStack{
                if viewMode {
                    //Name
                    Text(appUser.username)
                        .font(Constants.titleFont)
                        .padding(.leading, 25)
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
                    //.frame(width: 20)
                }
            }
            
            HStack{
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(Color.highlight)
                    .font(.system(size: 20))
                    .padding(.leading, 20)
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
                            .frame(width: (UIScreen.main.bounds.width)-20, height: (UIScreen.main.bounds.width)/6)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                    }
                    Spacer()
                        .frame(width: 20)
                } else {
                    Spacer()
                        .frame(width: 20)
                    ScrollView {
                        TextEditor(text: $appUser.bio)
                            .font(Constants.textFontSmall)
                            .frame(width: (UIScreen.main.bounds.width)-20, height: (UIScreen.main.bounds.width)/6)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.gray)
                            .padding([.leading, .top, .bottom, .trailing], 3)
                        //.padding(.trailing, -10)
                            .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                    }
                    Spacer()
                    //.frame(width: 20)
                }
            }
            
            
            Divider()
            Spacer()
            
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { image in
            guard let image = image else { return }
            UserStorage.putImage(image, url: "users/\(appUser.uid)/profile_pic") { url, error in
                if let url = url {
                    appUser.profilePic = url.absoluteString
                    UserData.pushUser(appUser)
                } else {
                    print(error)
                }
            }
        }
    }
    
}

struct PersonalProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalProfileView()
            .environmentObject(User())
    }
}
