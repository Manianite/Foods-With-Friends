//
//  Foods_With_FriendsApp.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/1/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Foods_With_FriendsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appUser: User = User()
    @StateObject var locationManager = LocationManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appUser)
                .environmentObject(locationManager)

        }
    }
}
