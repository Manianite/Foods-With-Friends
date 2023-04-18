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
      //requestNotificationAuthorization(application: application)
      registerForPushNotifications(application: application)
    return true
  }
    
   
    
    func /*requestNotificationAuthorization*/ registerForPushNotifications(application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]

        center.requestAuthorization(options: options) { (granted, error) in
//            if let error = error {
//                print(error.localizedDescription)
//            }
            
            // 1. Check to see if permission is granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
}

//private func registerForPushNotifications() {
//    UNUserNotificationCenter.current().delegate = self
//    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
//        (granted, error) in
//        // 1. Check to see if permission is granted
//        guard granted else { return }
//        // 2. Attempt registration for remote notifications on the main thread
//        DispatchQueue.main.async {
//            UIApplication.shared.registerForRemoteNotifications()
//        }
//    }
//}
extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
}

@main
struct Foods_With_FriendsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appUser: User = User()

    // this is what was there for me, keeping it here for reference just in case (Busra): @StateObject var locationManager = LocationManager.shared
    @Environment(\.scenePhase) var scenePhase
   // @StateObject var locationManager: LocationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appUser)

//                .environmentObject(locationManager)
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
                        UIApplication.shared.applicationIconBadgeNumber = 0
                    }
                }
        }
    }
}
