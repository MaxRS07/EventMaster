//
//  EventScrollView.swift
//  EventMaster
//
//  Created by Max Siebengartner on 17/3/2024.
//

import Foundation
import SwiftUI

struct EventScrollView : View {
    var body: some View {
        @State var events : [Event] = []
        HStack {
            ScrollView(.horizontal) {
                ForEach($events) { e in
                    EventCard(event: e)
                }
            }
        }
    }
}
#Preview {
    EventScrollView()
}
