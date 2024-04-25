//
//  Tylers_Training_TrackerApp.swift
//  Tylers Training Tracker
//
//  Created by Tyler Remy on 4/7/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Tylers_Training_TrackerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authApp = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authApp.userSession == nil {
                LoginView()
                    .environmentObject(authApp)
            } else {
                UserHomeView()
                    .environmentObject(authApp)
            }
        }
    }
}
