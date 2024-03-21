//
//  ContentView.swift
//  EventMaster
//
//  Created by Max Siebengartner on 15/3/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var userAuth : UserAuth
    @State var progress = 0.01
    @State var entranceCompleted : Bool = false
    @State var searchQuery: String = ""
    @Binding var contentLoaded : Bool
    
    @State var events: [Event] = [
        Event(
            image: UIImage(named: "Placeholder")!.pngData()!,
            name: "Tryouts",
            desc: "Tryouts for sports",
            date: Date.now.formatDate(format: "YYYY MM dd hh:mm"),
            location: "Room 504",
            tags: [.Sports],
            hosts: ["Max", "Fred"]
        ),
    ]
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                if !entranceCompleted {
                    VStack {
                        ProgressView(value: progress)
                            .frame(width: 200)
                            .tint(.white)
                            .padding()
                        Text("Fetching Content...")
                            .foregroundStyle(.white)
                    }
                    
                }
                VStack {
                    Spacer()
                    VStack {
                        Color(.white)
                            .offset(y: 100)
                            .frame(height: 100)
                        FancySearchField(text: $searchQuery)
                            .frame(width: 320)
                            .offset(y: -29)
                        TagView(text: $searchQuery)
                            .padding(.horizontal)
                            .offset(y: -20)
                    }
                    
                    VStack {
                        GeometryReader {geo in
                            let width = geo.size.width
                            let height = geo.size.height
                            ZStack {
                                ScrollView(showsIndicators: false) {
                                    VStack {
                                        HStack {
                                            Text("Trending")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .padding(.leading, 30)
                                            Spacer()
                                        }
                                        EventScrollView(events: events)
                                        
                                        HStack {
                                            Text("Upcoming")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .padding(.leading, 30)
                                            Spacer()
                                        }
                                        EventScrollView(events: events)
                                        Spacer()
                                    }
                                    .offset(x: searchQuery == "" ? 0 : width)
                                    .animation(.easeInOut)
                                    
                                }
                                SearchView(query: $searchQuery, objects: $events)
                                    .offset(x: searchQuery == "" ? -width : 0)
                                    .animation(.easeInOut)
                            }
                        }
                    }
                    .frame(height: 620)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .background(.white)
                }
                .onAppear {
                    var count = 0
                    Timer.scheduledTimer(withTimeInterval: 0.005, repeats: true) { timer in
                        progress += 0.005
                        count += 1
                        
                        if count > 200 {
                            timer.invalidate()
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            //load content
                            entranceCompleted = true
                            contentLoaded = true
                        }
                    }
                }
                .offset(y: entranceCompleted ? 50 : 1000)
            }
        }
    }
}
struct TagView : View {
    @Binding var text : String
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(EventTags.allCases, id: \.self) { tag in
                    if !text.contains("\"" + tag.rawValue + "\"") {
                        Button {
                            text += " \"" + tag.rawValue + "\" "
                        } label: {
                            Text(tag.rawValue)
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
        }
    }
}
struct FancySearchField : View {
    @Binding var text: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color(uiColor: .systemGray4))
            TextField("Search", text: $text)
                .padding(.vertical, 15)
            Button {
                text = ""
            } label: {
                Image(systemName: "xmark.circle")
                    .foregroundStyle(Color(uiColor: .systemGray4))
            }
        }
        .padding(.horizontal, 20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 8)
    }
}
