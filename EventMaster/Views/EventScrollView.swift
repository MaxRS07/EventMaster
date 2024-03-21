//
//  EventScrollView.swift
//  EventMaster
//
//  Created by Max Siebengartner on 17/3/2024.
//

import Foundation
import SwiftUI

struct EventScrollView : View {
    @EnvironmentObject var userAuth : UserAuth
    @State var events : [Event] = []
    
    var body: some View {
        HStack {
            ScrollView(.horizontal) {
                VStack {
                    ForEach(events) { e in
                        NavigationLink(destination: EventDetailView(event: e)) {
                            EventCard(event: e)
                        }
                    }
                }
                .padding()
            }
        }
    }
}
