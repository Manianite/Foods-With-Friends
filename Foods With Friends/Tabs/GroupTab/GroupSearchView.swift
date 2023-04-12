//
//  GroupSearchView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/23/23.
//

import SwiftUI

struct GroupSearchView: View {
    @State var query = ""
    @EnvironmentObject var appUser: User
    @Binding var groupsList: [FoodGroup]
    @State var groups: [PublicFoodGroup] =  []
    @State var filteredGroups: [PublicFoodGroup] = []
    var body: some View {
        ZStack {
            ScrollView {
                ForEach($filteredGroups, id: \.self.name) { group in
                    ZStack(alignment: .trailing) {
                        GroupListView(publicGroup: group)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(.tertiary, lineWidth: 1))
                            .padding([.trailing, .leading], 5)
                        Button {
                            UserData.setValue(group.isPublic.wrappedValue ? "member" : "incoming", to: "groups/\(group.gid.wrappedValue)/members/\(appUser.uid)")
                            UserData.setValue(group.isPublic.wrappedValue ? "member" : "incoming", to: "users/\(appUser.uid)/groups/\(group.gid.wrappedValue)")
                            appUser.groups[group.gid.wrappedValue] = group.isPublic.wrappedValue ? "member" : "incoming"
                            UserData.getBranch(from: "groups/\(group.gid.wrappedValue)", as: FoodGroup.self) { fullGroup in
                                groupsList.append(fullGroup)
                            }
                            
                            if group.isPublic.wrappedValue {
                                groups.removeAll {$0==group.wrappedValue}
                                withAnimation {
                                    filteredGroups.removeAll {$0==group.wrappedValue}
                                }
                            }
                        } label: {
                            Image(systemName: group.isPublic.wrappedValue ? "plus.app.fill" : "paperplane.fill")
                                .resizable()
                                .frame(width: (UIScreen.main.bounds.width)/7, height: (UIScreen.main.bounds.width)/7)
                                .accentColor(.highlight)
                                .padding(.trailing, 15)
                        }
                        .disabled(appUser.groups[group.gid.wrappedValue] == "incoming")
                    }
                }
                .navigationTitle("All Groups")
                .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $query)
        }
        .background(Color.secondarySystemBackground)
        .onAppear {
            UserData.getBranch(from: "groups/group_dict", as: [String: PublicFoodGroup].self) { groupList in
                groups = Array(groupList.values).filter { group in
                    !(appUser.groups.keys.contains(group.gid) && appUser.groups[group.gid] != "incoming")
                }
                filteredGroups = groups
            }
        }
        .onChange(of: query) { newValue in
            let filtering = groups.filter { $0.name.lowercased().contains(query.lowercased()) }
            if !filtering.containsSameElements(as: filteredGroups) {
                filteredGroups = filtering
            }
        }
    }
}

struct GroupSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GroupSearchView(groupsList: .constant([FoodGroup()]))
    }
}
