//
//  ContentView.swift
//  EventMaster
//
//  Created by Max Siebengartner on 21/3/2024.
//

import Foundation
import SwiftUI

struct ContentView : View {
    @EnvironmentObject var userAuth : UserAuth
    @State var contentLoaded : Bool = false
    var body: some View {
        TabView() {
            HomeView(contentLoaded: $contentLoaded).tabItem { Label("Home", systemImage: "house") }.tag(1)
            ProfileView().tabItem { Label("Profile", systemImage: "person.crop.circle.fill") }.tag(2)
        }
        .disabled(!contentLoaded)
        .background(Color(.clear).blur(radius: 40))
    }
}
