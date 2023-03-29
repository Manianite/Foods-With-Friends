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
    @State var groups: [PublicFoodGroup] =  []
    @State var filteredGroups: [PublicFoodGroup] = []
    var body: some View {
        ZStack {
            ScrollView {
                ForEach($filteredGroups, id: \.self.name) { group in
                    ZStack(alignment: .trailing) {
                        GroupListView(publicGroup: group)
                            .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(.black))
                            .padding([.trailing, .leading], 5)
                        Button {
                            UserData.setValue(group.isPublic.wrappedValue ? "member" : "incoming", to: "groups/\(group.gid.wrappedValue)/members/\(appUser.uid)")
                            UserData.setValue(group.isPublic.wrappedValue ? "member" : "incoming", to: "users/\(appUser.uid)/groups/\(group.gid.wrappedValue)")
                            if group.isPublic.wrappedValue {
                                groups.removeAll {$0==group.wrappedValue}
                            }
                        } label: {
                            Image(systemName: group.isPublic.wrappedValue ? "plus.fill" : "paperplane.fill")
                                .resizable()
                                .frame(width: (UIScreen.main.bounds.width)/7, height: (UIScreen.main.bounds.width)/7)
                                .accentColor(.highlight)
                                .padding(.trailing, 15)
                        }
                        .disabled(appUser.groups.contains { (key, value) in
                            value == "incoming"
                        })
                    }
                }
                .navigationTitle("All Groups")
                .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $query)
        }
        .onAppear {
            UserData.getBranch(from: "groups/group_dict", as: [String: PublicFoodGroup].self) { groupList in
                groups = Array(groupList.values).filter { group in
                    !appUser.groups.keys.contains(group.gid)
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
        GroupSearchView()
    }
}
