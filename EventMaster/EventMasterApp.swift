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
    FirebaseApp.configure()

    return true
  }
}

@main
struct EventMasterApp: App {

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
