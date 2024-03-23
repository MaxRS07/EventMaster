//
//  EventMasterApp.swift
//  EventMaster
//
//  Created by Max Siebengartner on 15/3/2024.
//

import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    return true
  }
}

@main
struct EventMasterApp: App {
    @StateObject var userAuth = UserAuth()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if userAuth.authState == .loggedOut {
                ContentView()
            } else if userAuth.authState == .loggedOut {
                LoginView()
            }
        }
        .environmentObject(userAuth)
    }
}
