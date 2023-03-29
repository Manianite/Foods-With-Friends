//
//  NewGroupView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/25/23.
//

import SwiftUI
import struct Kingfisher.KFImage

struct NewGroupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appUser: User
    @Binding var groupsList: [FoodGroup]
    @State var name = ""
    @State var isPublic = false
    @State var inputImage: UIImage?
    @State var showingImagePicker = false
    @State var showingNameInput = true
    var body: some View {
        VStack {
            Text("New Group")
                .font(Constants.titleFont)
            Button {
                showingImagePicker = true
            } label: {
                //group pic
                ZStack(alignment: .bottom) {
                    if let image = inputImage {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width)/2, height: (UIScreen.main.bounds.width)/2)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .padding(5)
                    } else {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width)/2, height: (UIScreen.main.bounds.width)/2)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .padding(5)
                    }
                    Text("Edit")
                        .padding(.horizontal, 5)
                        .padding(.top, 2)
                        .background(Color.highlight.opacity(0.5))
                        .cornerRadius(40)
                        .frame(width: (UIScreen.main.bounds.width)/5, height: (UIScreen.main.bounds.width)/4)
                        .foregroundColor(Color.white)
                        .font(Constants.textFontSmall)
                        .font(.system(size: 30))
                        .padding(.leading, 8)
                }
            }
            .foregroundColor(.black)

            TextField("Group name", text: $name)
                .font(Constants.titleFont)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color.gray)
                .padding(.leading, 5)
                .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
            Toggle(isOn: $isPublic) {
                Text("Public?")
                    .font(Constants.titleFont)
            }
            
            Spacer()
            
            Button {
                if let image = inputImage {
                    UserStorage.putImage(image, url: "groups/\(appUser.uid)/group_pic") { url, error in
                        if let url = url {
                            let group = FoodGroup(name: name, creatorID: appUser.uid, isPublic: isPublic, img: url.absoluteString)
                            UserData.pushGroup(group)
                            appUser.groups[group.gid] = "creator"
                            UserData.pushUser(appUser)
                            groupsList.insert(group, at: 0)
                        } else {
                            let group = FoodGroup(name: name, creatorID: appUser.uid, isPublic: isPublic)
                            UserData.pushGroup(group)
                            appUser.groups[group.gid] = "creator"
                            UserData.pushUser(appUser)
                            groupsList.insert(group, at: 0)
                            print(error)
                        }
                    }
                } else {
                    let group = FoodGroup(name: name, creatorID: appUser.uid, isPublic: isPublic)
                    UserData.pushGroup(group)
                    appUser.groups[group.gid] = "creator"
                    UserData.pushUser(appUser)
                    groupsList.insert(group, at: 0)
                }
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Create Group!")
                    .font(Constants.titleFont)
                    .foregroundColor(.highlight)
                    .padding(.horizontal, 5)
                    .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
            }
            .padding()
        }
        .padding()
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
}

struct NewGroupView_Previews: PreviewProvider {
    static var previews: some View {
        NewGroupView(groupsList: .constant([]))
    }
}
