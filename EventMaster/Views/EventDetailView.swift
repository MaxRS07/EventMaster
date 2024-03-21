//
//  EventDetail.swift
//  EventMaster
//
//  Created by Max Siebengartner on 17/3/2024.
//

import Foundation
import SwiftUI

struct EventDetailView : View {
    @State var event: Event
    @EnvironmentObject var userAuth: UserAuth
    
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
                        .padding(.bottom)
                    HStack {
                        Text(event.desc)
                            .padding(.bottom)
                            .padding(.leading, width * 0.1)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(event.date)
                        Divider()
                        Text(event.location)
                        Divider()
                        VStack {
                            ForEach(event.hosts, id: \.self) { host in
                                Text(host)
                            }
                        }
                        Spacer()
                    }
                    .frame(height: height * 0.05)
                    .padding()
                    HStack {
                        Button {
                            
                        } label: {
                            Text("Register")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    EventCalendar(observedDate: Date.decode(date: event.date)!)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
