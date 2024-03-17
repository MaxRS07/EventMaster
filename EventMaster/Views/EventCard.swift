//
//  EventCard.swift
//  EventMaster
//
//  Created by Max Siebengartner on 17/3/2024.
//

import Foundation
import SwiftUI

struct EventCard : View {
    @Binding var event : Event
    var body: some View {
        VStack {
            Image(uiImage: .init(data: event.image)!)
                .resizable()
                .frame(height: 100)
            HStack {
                Text(event.name)
                    .padding(.leading)
                    .font(.title3)
                Spacer()
            }
            HStack {
                Text(event.desc)
                    .padding(.leading)
                Spacer()
            }
            Spacer()
        }
        .frame(width: 150, height: 200)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .clipped()
        .shadow(radius: 8)
    }
}
struct Previews : View {
    @State var event = Event(
        image: UIImage(named: "Placeholder")!.pngData()!,
        name: "Tryouts",
        desc: "Tryouts for sports",
        date: Date.now.description
    )
    var body: some View {
        EventCard(event: $event)
    }
}
#Preview {
    Previews()
}
