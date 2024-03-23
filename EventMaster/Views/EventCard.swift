//
//  EventCard.swift
//  EventMaster
//
//  Created by Max Siebengartner on 17/3/2024.
//

import Foundation
import SwiftUI

struct EventCard : View {
    @State var event : Event
    var body: some View {
        VStack {
            Image(uiImage: .init(data: event.images.first!)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.frame(height: 100)
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
        .frame(width: 160, height: 170)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .clipped()
        .shadow(radius: 8)
    }
}
struct EventSearchCard : View {
    @State var event: Event
    var body: some View {
        HStack {
            Image(uiImage: .init(data: event.images.first!)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 130)
            VStack {
                HStack {
                    Text(event.name)
                        .padding(.top, 18)
                        .font(.title3)
                    Spacer()
                }
                HStack {
                    Text(event.desc)
                        .font(.body)
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(width: 350, height: 120)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 8)
    }
}
struct CardPreviews : View {
    @State var event = Event(
        images: [UIImage(named: "Placeholder")!.pngData()!],
        name: "Tryouts",
        desc: "Tryouts for sports",
        date: Date.now.description,
        location: "Room 504", 
        hosts: []
    )
    var body: some View {
        VStack {
            EventCard(event: event)
                .padding()
            EventSearchCard(event: event)
        }
    }
}
#Preview {
    CardPreviews()
}
