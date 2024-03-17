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
    
    var body: some View {
        HStack {
            if avalible == nil {
                Text("Username must be between 6 and 20 characters")
                    .foregroundStyle(Color(uiColor: .systemGray4))
            }
            else if !avalible! {
                Text("Username taken")
                    .foregroundStyle(.red)
            } else if avalible! {
                Text("Username taken")
                    .foregroundStyle(.green)
            }
        }
        .font(.system(size: 11))
        .foregroundStyle(Color(uiColor: .systemGray4))
        .multilineTextAlignment(.leading)
        .onChange(of: username) {
            
        }
    }
}
