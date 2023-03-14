//
//  AppView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/8/23.
//

import SwiftUI

struct AppView: View {
    @State var selectedTab = Tabs.SettingsView
    @Binding var viewState: ViewState
    var body: some View {
        VStack {
            HStack{
                VStack {
                    Image(systemName: "gear")
                        .foregroundColor(selectedTab == .SettingsView ? Color.highlight : Color.black.opacity(0.7))
                        .font(.system(size: 25))
                    Text("Settings")
                        .foregroundColor(selectedTab == .SettingsView ? Color.highlight.opacity(0.7) : Color.black.opacity(0.7))
                        .font(Constants.tabFont)
                }
                .padding(.leading, 30.0)
                .onTapGesture {
                    selectedTab = .SettingsView
                }
                Spacer()
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                Spacer()
                VStack {
                    Image(systemName: "person")
                        .foregroundColor(selectedTab == .ProfileView ? Color.highlight : Color.black.opacity(0.7))
                        .font(.system(size: 25))

                    Text("Profile")
                        .foregroundColor(selectedTab == .ProfileView ? Color.highlight.opacity(0.7) : Color.black.opacity(0.7))
                        .font(Constants.tabFont)
                }
                .padding(.trailing, 30.0)
                .onTapGesture {
                    selectedTab = .ProfileView
                }
                
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            Divider()
                .padding(.vertical, 7)
            
            Spacer()
            
            if selectedTab == .SettingsView {
                SettingsView()
            } else if selectedTab == .ProfileView {
                ProfileView()
            } else if selectedTab == .HomeView {
                HomeView("", lineLimit: 1)
            } else if selectedTab == .SearchView {
                SearchView()
            } else if selectedTab == .FriendView {
                FriendView()
            } else if selectedTab == .NewPostView {
                NewPostView()
            }
            
            Spacer()
            
            Divider()
                .padding(.vertical, 7)

            HStack {
                VStack {
                    Image(systemName: "house")
                        .foregroundColor(selectedTab == .HomeView ? Color.highlight : Color.black.opacity(0.7))
                        .font(.system(size: 20))
                        .font(.system(size: 25))

                    Text("Home")
                        .foregroundColor(selectedTab == .HomeView ? Color.highlight.opacity(0.7) : Color.black.opacity(0.7))
                        .font(Constants.tabFont)

                }
                .padding(.leading, 35)
                .onTapGesture {
                    selectedTab = .HomeView
                }
                
                Spacer()
                VStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(selectedTab == .SearchView ? Color.highlight : Color.black.opacity(0.7))
                        .font(.system(size: 25))

                    Text("Search")
                        .foregroundColor(selectedTab == .SearchView ? Color.highlight.opacity(0.7) : Color.black.opacity(0.7))
                        .font(Constants.tabFont)

                }
                .onTapGesture {
                    selectedTab = .SearchView
                }
                Spacer()
                VStack {
                    Image(systemName: "person.2")
                        .foregroundColor(selectedTab == .FriendView ? Color.highlight : Color.black.opacity(0.7))
                        .font(.system(size: 25))

                    Text("Friends")
                        .foregroundColor(selectedTab == .FriendView ? Color.highlight.opacity(0.7) : Color.black.opacity(0.7))
                        .font(Constants.tabFont)

                }
                .onTapGesture {
                    selectedTab = .FriendView
                }
                Spacer()
                VStack {
                    Image(systemName: "plus.app")
                        .foregroundColor(selectedTab == .NewPostView ? Color.highlight : Color.black.opacity(0.7))
                        .font(.system(size: 25))

                    Text("Post")
                        .foregroundColor(selectedTab == .NewPostView ? Color.highlight.opacity(0.7) : Color.black.opacity(0.7))
                        .font(Constants.tabFont)

                }
                .padding(.trailing, 35)

                .onTapGesture {
                    selectedTab = .NewPostView
                }
                
            }
            .frame(height: 3.0)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .padding(.top, 20.0)
            .padding(.bottom, 16)
        }
    }
}

enum Tabs {
    case SettingsView
    case ProfileView
    case HomeView
    case SearchView
    case FriendView
    case NewPostView
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(viewState: Binding.constant(.home))
    }
}
