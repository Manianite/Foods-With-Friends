//
//  AppView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/8/23.
//

import SwiftUI

struct AppView: View {
    @State var selectedTab = Tabs.HomeView
    @State var chosen : Restaurant?
    @Binding var viewState: ViewState
    @StateObject var locationManager = LocationManager()
    
    

    var body: some View {
        //ViewController()
        VStack(spacing: 0) {
            HStack{
                VStack {
                    Image(systemName: "gear")
                        .foregroundColor(selectedTab == .SettingsView ? Color.highlight : Color.black.opacity(0.7))
                        .font(.system(size: 25))
                    Text("Settings")
                        .foregroundColor(selectedTab == .SettingsView ? Color.highlight.opacity(0.7) : Color.black.opacity(0.7))
                        .font(Constants.tabFont)
                }
                .padding(.leading, 15.0)
                .onTapGesture {
                    selectedTab = .SettingsView
                }
                Spacer()
                Image("bannerlogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 50)
                Spacer()
                VStack {
                    Image(systemName: "person")
                        .foregroundColor(selectedTab == .ProfileView ? Color.highlight : Color.black.opacity(0.7))
                        .font(.system(size: 25))

                    Text("Profile")
                        .foregroundColor(selectedTab == .ProfileView ? Color.highlight.opacity(0.7) : Color.black.opacity(0.7))
                        .font(Constants.tabFont)
                }
                .padding(.trailing, 15.0)
                .onTapGesture {
                    selectedTab = .ProfileView
                }
                
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            Divider()
                .padding(.top, 7)
            
            if selectedTab == .SettingsView {
                SettingsView(viewState: $viewState)
            } else if selectedTab == .ProfileView {
                ProfileView()
            } else if selectedTab == .HomeView {
                HomeView()
            } else if selectedTab == .GroupView {
                GroupsView()
            } else if selectedTab == .SearchView {
                SearchView(selectedTab: $selectedTab, chosen: $chosen)
            } else if selectedTab == .FriendView {
                FriendView()
            } else if selectedTab == .NewPostView {
                NewPostView(selectedTab: $selectedTab, chosen: $chosen)
            }
            
            Divider()
                .padding(.bottom, 7)

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
                .padding(.leading, 30)
                .onTapGesture {
                    selectedTab = .HomeView
                }
                Spacer()
                VStack {
                    Image(systemName: "person.3")
                        .foregroundColor(selectedTab == .GroupView ? Color.highlight : Color.black.opacity(0.7))
                        .font(.system(size: 20))
                        .font(.system(size: 25))

                    Text("Groups")
                        .foregroundColor(selectedTab == .GroupView ? Color.highlight.opacity(0.7) : Color.black.opacity(0.7))
                        .font(Constants.tabFont)

                }
                .onTapGesture {
                    selectedTab = .GroupView
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
                .padding(.trailing, 30)

                .onTapGesture {
                    selectedTab = .NewPostView
                }
                
            }
            .frame(height: 3.0)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .padding(.top, 20.0)
            .padding(.bottom, 16)
        }
    
        .environmentObject(locationManager)
    }
}


enum Tabs {
    case SettingsView
    case ProfileView
    case HomeView
    case GroupView
    case SearchView
    case FriendView
    case NewPostView
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(viewState: Binding.constant(.home))
           
    }
}


