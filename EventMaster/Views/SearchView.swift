//
//  SearchView.swift
//  EventMaster
//
//  Created by Max Siebengartner on 17/3/2024.
//

import Foundation
import SwiftUI

struct SearchView : View {
    @Binding var query : String
    @Binding var objects : [Event]
    @EnvironmentObject var userAuth : UserAuth
    @State private var filtered: [Event] = []
    
    var body: some View {
        VStack {
            HStack {
                Text("Results (\(filtered.count))")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.leading, 30)
                Spacer()
            }
            .padding(.bottom, 10)
            
            ScrollView {
                HStack {
                    ForEach(filtered) {event in
                        NavigationLink(destination: EventDetailView(event: event)) {
                            EventSearchCard(event: event)
                        }
                    }
                }
                .padding()
            }
            Spacer()
        }
        .onChange(of: query) {
            let eventTags = EventTags.allCases.map({"\"\($0.rawValue)\""})
            let tags = eventTags.filter({query.contains("\"\($0)\"")})
            let filteredQuery = query.components(separatedBy: " ")
            let newQuery = filteredQuery.filter({!eventTags.contains($0)}).joined(separator: " ")
            filtered = objects.filter {
                ($0.name + " " + $0.desc).range(of: newQuery, options: .caseInsensitive) != nil && Set(tags) == Set($0.tags)
            }
        }
    }
}
