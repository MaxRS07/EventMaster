//
//  UsernameCheck.swift
//  EventMaster
//
//  Created by Max Siebengartner on 17/3/2024.
//

import Foundation
import SwiftUI

struct UsernameCheck : View {
    @Binding var username : String
    @State private var avalible : Bool?
    @State private var checking : Bool = false
    
    var body: some View {
        HStack {
            if !(6...20).contains(username.count) {
                Text("Username must be between 6 and 20 characters")
                    .foregroundStyle(Color(uiColor: .systemGray4))
            }
            else if (username.range(of: "^([a-zA-Z0-9._])*$", options: .regularExpression) == nil) {
                Text("Invalid Characters")
                    .foregroundStyle(Color(uiColor: .red))
            }
            else if !avalible! {
                Text("Username taken")
                    .foregroundStyle(.red)
            } else if avalible! {
                Text("Username avalible")
                    .foregroundStyle(.green)
            }
            Spacer()
        }
        .opacity(avalible == nil ? 0 : 1)
        .font(.system(size: 11))
        .foregroundStyle(Color(uiColor: .systemGray4))
        .multilineTextAlignment(.leading)
        .onChange(of: username) {
            checking = true
            Task {
                avalible = await UserManager.fetchUser(username: username) == nil
                checking = false
            }
        }
    }
}
