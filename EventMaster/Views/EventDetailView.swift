//
//  EventDetail.swift
//  EventMaster
//
//  Created by Max Siebengartner on 17/3/2024.
//

import Foundation
import SwiftUI

struct EventDetailView : View {
    @Binding var event: Event
    
    var body: some View {
        VStack {
            
        }
    }
}
struct Preview : View {
    @State var event = Event(
        image: UIImage(named: "Placeholder")!.pngData()!,
        name: "Tryouts",
        desc: "Tryouts for sports",
        date: Date.now.description
    )
    var body: some View {
        EventDetailView(event: $event)
    }
}
#Preview {
    Preview()
}
