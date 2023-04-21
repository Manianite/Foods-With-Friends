//
//  GroupView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/23/23.
//

import SwiftUI

struct GroupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appUser: User
    @Binding var group: FoodGroup
    @Binding var groupsList: [FoodGroup]
    @Binding var insideNavigator: Bool
    @State var memberReqsList: [PublicUser] = []
    @State var reviews: [Review] = []
    @State var showingLeaveGroupWarning = false
    @State  var showingSheet = false
    
    var body: some View {
        VStack {
            Text(group.name)
                .font(Constants.titleFont)
            Text("\(group.members.count) members")
                .font(Constants.textFontSmall)
//            Button {
//                showingSheet.toggle()
//            }label: {
//                Text("\(group.members.count) members")
//                    .font(Constants.textFontSmall)
//            } .sheet(isPresented: $showingSheet) {
//                ForEach(Array(group.members.keys), id: \.self) { friend in
//                    NavigationLink {
//                        FriendProfileView(uid: friend.uid, friendsList: $group.members)
//                    } label: {
//                        PublicUserView(user: friend)
//                            .background(.white)
//                            .cornerRadius(10)
//                            .overlay(RoundedRectangle(cornerRadius: 10)
//                                .stroke(.tertiary, lineWidth: 1))
//                            .padding([.trailing, .leading], 5)
//                    }
//                    .buttonStyle(.plain)
//                    .padding(.bottom, -5)
//                }
//            }
            
            Divider()
            ScrollView {
                ForEach($memberReqsList, id: \.self.uid) { memberReq in
                    ZStack(alignment: .trailing) {
                        PublicUserView(user: memberReq)
                            .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(.black).background(.white))
                            .padding([.trailing, .leading], 5)
                            .transition(.move(edge: .bottom))
                        HStack {
                            Button {
                                UserData.remove("groups/\(group.gid)/members/\(memberReq.uid)")
                                UserData.remove("users/\(memberReq.uid)/groups/\(group.gid)")
                                appUser.groups.removeValue(forKey: group.gid)
                                group.members.removeValue(forKey: memberReq.uid.wrappedValue)
                                memberReqsList.removeAll {$0.uid == memberReq.uid.wrappedValue}
                            } label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: (UIScreen.main.bounds.width)/8, height: (UIScreen.main.bounds.width)/8)
                                    .accentColor(.red)
                                    .padding(.trailing, 5)
                            }
                            Divider()
                            Button {
                                UserData.setValue("member", to: "groups/\(group.gid)/members/\(memberReq.uid.wrappedValue)")
                                UserData.setValue("member", to: "users/\(memberReq.uid.wrappedValue)/groups/\(group.gid)")
                                appUser.groups[group.gid] = "member"
                                group.members.removeValue(forKey: memberReq.uid.wrappedValue)
                                memberReqsList.removeAll {$0.uid == memberReq.uid.wrappedValue}
                            } label: {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: (UIScreen.main.bounds.width)/8, height: (UIScreen.main.bounds.width)/8)
                                    .accentColor(.green)
                                    .padding(.trailing, 18)
                            }
                        }
                    }
                }
                ForEach($reviews) { review in
                    ReviewView(review: review)
                        .background(.white)
                        .cornerRadius(15)
                        .padding(.horizontal, 10)
                        .padding(.top, 5)
                }
            }
            .onAppear {
                UserData.observeFeed(for: "groups/\(group.gid)/feed") { gotReviews in
                    reviews = Array(gotReviews.values).filter {$0.uid != ""}
                }
                for memberReqUid in Array(group.members.filter {$0.value == "incoming"}.keys) {
                    //print(memberReqUid)
                    UserData.getPublicUser(memberReqUid) { memberReq in
                        //print(memberReq.username)
                        memberReqsList.append(memberReq)
                    }
                }
            }
            .onDisappear {
                UserData.stopObservingFeed()
            }
        }
        .background(Color.secondarySystemBackground)
        .navigationBarItems(trailing: group.gid==appUser.uid ? AnyView(NavigationLink("Edit", isActive: $insideNavigator) {EditGroupView(group, groups: $groupsList, isActive: $insideNavigator)}) : AnyView(Button("Leave") {showingLeaveGroupWarning = true}))
        .alert(isPresented: $showingLeaveGroupWarning) {
            Alert (
                title: Text("Foods With Friends"),
                message: Text("Are you sure you want to leave \(group.name)?"),
                primaryButton: .destructive(Text("Leave")) {
                    UserData.remove("users/\(appUser.uid)/groups/\(group.gid)")
                    UserData.remove("groups/group_dict/\(group.gid)/members/\(appUser.uid)")
                    appUser.groups.removeValue(forKey: group.gid)
                    groupsList.removeAll {$0.gid==group.gid}
                    insideNavigator = false
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(group: .constant(FoodGroup()), groupsList: .constant([]), insideNavigator: .constant(false), memberReqsList: [])
    }
}
