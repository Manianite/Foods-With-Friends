//
//  EditGroupView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/29/23.
//

import SwiftUI
import struct Kingfisher.KFImage

struct EditGroupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appUser: User
    var group: FoodGroup
    @Binding var insideNavigator: Bool
    @Binding var groupsList: [FoodGroup]
    @State var name: String
    @State var isPublic: Bool
    @State var inputImage: UIImage?
    @State var showingImagePicker = false
    @State var showingNameInput = true
    @State var deleteAssurance = false
    
    init(_ group: FoodGroup, groups: Binding<[FoodGroup]>, isActive insideNavigator: Binding<Bool>) {
        _insideNavigator = Binding(projectedValue: insideNavigator)
        _groupsList = Binding(projectedValue: groups)
        self.group = group
        _name = State(initialValue: group.name)
        _isPublic = State(initialValue: group.isPublic)
    }

    var body: some View {
        VStack {
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
                        KFImage(URL(string: group.img))
                            .placeholder {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .frame(width: (UIScreen.main.bounds.width)/2, height: (UIScreen.main.bounds.width)/2)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .padding(5)
                            }
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
            
            HStack {
                Button {
                    deleteAssurance = true
                } label: {
                    Text("Delete Group")
                        .font(Constants.titleFont)
                        .foregroundColor(.highlight)
                        .padding(.horizontal, 5)
                        .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                }
                Button {
                    if let image = inputImage {
                        UserStorage.putImage(image, url: "groups/\(appUser.uid)/group_pic") { url, error in
                            if let url = url {
                                group.name = name
                                group.isPublic = isPublic
                                group.img = url.absoluteString
                                UserData.pushGroup(group)
                            } else {
                                group.name = name
                                group.isPublic = isPublic
                                UserData.pushGroup(group)
                                print(error)
                            }
                        }
                    } else {
                        group.name = name
                        group.isPublic = isPublic
                        UserData.pushGroup(group)
                    }
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                        .font(Constants.titleFont)
                        .foregroundColor(.highlight)
                        .padding(.horizontal, 5)
                        .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(Color.black))
                }
                .padding()
            }
        }
        .padding()
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .alert(isPresented: $deleteAssurance) {
            Alert (
                title: Text("Foods With Friends"),
                message: Text("Are you sure you want to delete \(group.name)?"),
                primaryButton: .destructive(Text("Delete")) {
                    for (member, _) in group.members {
                        UserData.remove("users/\(member)/groups/\(group.gid)")
                    }
                    UserStorage.deleteItem("groups/\(group.gid)/group_pic")
                    UserData.remove("groups/\(group.gid)")
                    UserData.remove("groups/group_dict/\(group.gid)")
                    appUser.groups.removeValue(forKey: group.gid)
                    groupsList.removeAll {$0.gid==appUser.uid}
                    insideNavigator = false
                },
                secondaryButton: .cancel()
            )
        }
        .navigationTitle("Edit Group")
    }
}

struct EditGroupView_Previews: PreviewProvider {
    static var previews: some View {
        EditGroupView(FoodGroup(), groups: .constant([]), isActive: .constant(true))
    }
}
