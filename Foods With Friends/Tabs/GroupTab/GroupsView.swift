//
//  GroupsView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/23/23.
//

import SwiftUI

struct GroupsView: View {
    @EnvironmentObject var appUser: User
    @State var query = ""
    @State var groupsList: [FoodGroup] = []
    @State var userHasGroupError = false
    @State var insideNavigator = false
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                if groupsList.count == 0 {
                    VStack {
                        Text("You have not joined any groups yet!")
                        Spacer()
                    }
                }
                ScrollView {
                    ForEach($groupsList, id: \.self.gid) { group in
                        NavigationLink {
                            GroupView(group: group, groupsList: $groupsList, insideNavigator: $insideNavigator)
                        } label: {
                            ZStack(alignment: .trailing) {
                                GroupListView(group: group)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(.tertiary, lineWidth: 1))
                                    .padding([.trailing, .leading], 5)
                                if group.gid.wrappedValue == appUser.uid {
                                    Image(systemName: "crown.fill")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width/7, height: UIScreen.main.bounds.width/8)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.yellow)
                                        .padding(10)
                                }
                            }
                        }
                        .buttonStyle(.plain)
//                        .padding(.bottom, -5)
                    }
                }
                HStack {
                    NavigationLink {
                        GroupSearchView(groupsList: $groupsList)
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width)/6, height: (UIScreen.main.bounds.width)/6)
                            .padding(.leading, 10)
                            .padding(.bottom, 10)
                            .foregroundColor(.highlight)
                    }
                    Spacer()
                    NavigationLink {
                        NewGroupView(groupsList: $groupsList)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width)/6, height: (UIScreen.main.bounds.width)/6)
                            .padding(.trailing, 10)
                            .padding(.bottom, 10)
                            .accentColor(.highlight)
                    }
                    .disabled(appUser.groups.contains { (key, value) in
                        key == appUser.uid
                    })
                }
            }
            .navigationBarTitle("My Groups", displayMode: .inline)
            .background(Color.secondarySystemBackground)
        }
        .searchable(text: $query)
        .onAppear {
            for groupID in appUser.groups.keys {
                UserData.getBranch(from: "groups/\(groupID)", as: FoodGroup.self) { group in
                    if group.gid != "_" && appUser.groups[group.gid] != "incoming" {
                        groupsList.append(group)
                    }
                }
            }
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}







































