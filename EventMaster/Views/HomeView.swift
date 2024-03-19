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
    
    @State var searchQuery: String = ""
    
    @State var events: [Event] = [
        Event(
            image: UIImage(named: "Placeholder")!.pngData()!,
            name: "Tryouts",
            desc: "Tryouts for sports",
            date: Date.now.description, 
            location: "Room 504"
        ),
    ]
    var body: some View {
        NavigationView {
            VStack {
                LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                //Spacer()
                VStack {
                    FancySearchField(text: $searchQuery)
                        .padding(.bottom, 5)
                    TagView(text: $searchQuery)
                }
                .frame(width: 320)
                .offset(y: -29)
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
                                
                                SearchView(query: $searchQuery, objects: $events)
                                    .offset(x: searchQuery == "" ? -width : 0)
                                    .animation(.easeInOut)
                            }
                        }
                    }
                }
                .frame(height: 520)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .background(.white)
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

#Preview {
    HomeView()
}
