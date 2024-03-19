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
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            HStack {
                Spacer()
                VStack {
                    Text(event.name)
                        .font(.title.bold())
                        .padding()
                    Image(uiImage: .init(data: event.image)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: width * 0.8)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    HStack {
                        Text(event.desc)
                            .padding(.bottom)
                            .padding(.leading, width * 0.1)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    HStack {
                        Text(event.date)
                        Divider()
                        Text(event.location)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
struct Preview : View {
    @State var event = Event(
        image: UIImage(named: "Placeholder")!.pngData()!,
        name: "Tryouts",
        desc: "Tryouts for sports",
        date: Date.now.formatDate(format: "MMM d, h:mm a"),
        location: "Room 504"
    )
    var body: some View {
        EventDetailView(event: $event)
    }
}
#Preview {
    Preview()
}
