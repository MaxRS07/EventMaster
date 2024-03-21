//
//  EventCalendar.swift
//  EventMaster
//
//  Created by Max Siebengartner on 20/3/2024.
//

import Foundation
import SwiftUI

struct EventCalendar : View {
    @EnvironmentObject var userAuth : UserAuth
    @State var observedDate : Date
    @State private var enrolled : [Event] = []
    var body: some View {
        VStack {
            HStack {
                if (observedDate.sameday(other: Date.now) && false) {
                    Text("Today")
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.horizontal, 30)
                        .foregroundStyle(.blue)
                }
                Spacer()
            }
            HStack {
                Button {
                    observedDate = observedDate.addTime(DateComponents(month: -1))
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10)
                }
                .padding(.leading, 30)
                Spacer()
                Text(observedDate.formatDate(format: .fullMonth))
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Spacer()
                Button {
                    observedDate = observedDate.addTime(DateComponents(month: 1))
                } label: {
                    Image(systemName: "chevron.forward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10)
                }
                .padding(.trailing, 30)
            }
            .padding(.bottom)
            
            CalendarHorizontalList(observedDate: $observedDate)
                .padding(.bottom)
            
            ForEach(enrolled) {event in
                EventSearchCard(event: event)
            }
        }
        .onAppear {
            Task {
                if let events = await userAuth.currentUser?.enrolledEvents(on: observedDate) {
                    enrolled = events
                }
            }
        }
        .onChange(of: observedDate) {
            Task {
                if let events = await userAuth.currentUser?.enrolledEvents(on: observedDate) {
                    enrolled = events
                }
            }
        }
    }
}
struct FullCalendarList : View {
    let week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @Binding var observedDate : Date
    var body: some View {
        VStack {
            HStack {
                ForEach(1...7, id: \.self) { i in
                    Text(week[i-1])
                        .frame(width: 35)
                }
            }
            Divider()
                .frame(width: 300)
            ForEach(0...6, id: \.self) { i in
                HStack {
                    ForEach(1...7, id: \.self) { j in
                        Text(String(6*i + j))
                            .padding(4)
                            .background(observedDate.day == 6*i + j ? .blue : .white)
                            .foregroundStyle(observedDate.day == 6*i + j ? .white : .black)
                            .clipShape(Circle())
                            .frame(width: 35)
                            
                    }
                }
                .padding(.top)
            }
        }
    }
}
struct CalendarHorizontalList : View {
    @Binding var observedDate : Date
    @State private var scrollPosition : Int? = 1
    let week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var body: some View {
        VStack {
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(1...observedDate.numberOfDaysInMonth(), id: \.self) { i in
                            Button {
                                observedDate = observedDate.addTime(.init(day: i - observedDate.day))
                            } label: {
                                VStack {
                                    Text(week[(observedDate.firstDayOfMonth().dayNumberOfWeek()!-1 + i-1) % 7])
                                        .padding(.bottom, 3)
                                    Text(String(i))
                                        .fontWeight(.semibold)
                                }
                                .frame(width: 40)
                                .padding(.vertical, 4)
                                .background(i == observedDate.day ? .blue : .white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundStyle(i == observedDate.day ? .white : .black)
                            }
                        }
                    }
                }
                .scrollPosition(id: $scrollPosition, anchor: .center)
                .padding(.horizontal)
            }
        }
    }
}
