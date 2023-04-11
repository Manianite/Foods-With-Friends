//
//  Foods_With_FriendsApp.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/1/23.
//

import SwiftUI
import FirebaseCore
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      requestNotificationAuthorization(application: application)
    return true
  }
    
    func requestNotificationAuthorization(application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        center.requestAuthorization(options: options) { (granted, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}

@main
struct Foods_With_FriendsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appUser: User = User()
    @StateObject var locationManager = LocationManager.shared
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appUser)
                .environmentObject(locationManager)
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
                        UIApplication.shared.applicationIconBadgeNumber = 0
                    }
                }
        }
    }
}
