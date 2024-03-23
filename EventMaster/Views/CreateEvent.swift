//
//  CreateEvent.swift
//  EventMaster
//
//  Created by Max Siebengartner on 22/3/2024.
//

import Foundation
import SwiftUI
import Photos
import PhotosUI

struct CreateEvent : View {
    @State private var photoItems: [PhotosPickerItem] = []
    @State private var images: [Image] = []
    @State private var name: String = ""
    @State private var desc: String = ""
    @State private var date: Date = .now
    @State private var tags: [EventTags] = []
    @State private var location: String = ""
    @State private var hosts: [String] = []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("Create Event")
                    .font(.title)
                    .bold()
                    .padding()
                    .padding(.bottom, 20)
                
                FancyTextField(text: $name, placeholder: "Title")
                    .padding()
                
                FancyTextField(text: $desc, placeholder: "Description")
                    .padding(.bottom)
                
                Text("Date and Time:")
                    .frame(width: 280, alignment: .leading)
                    .foregroundStyle(Color(uiColor: .systemGray3))
                DatePicker("", selection: $date)
                    .frame(width: 300, alignment: .leading)
                    .padding(.trailing, 100)
                    .padding(.bottom)
                
                FancyTextField(text: $location, placeholder: "Location eg. \"HS Room 504\"")
                    .padding(.bottom)
                
                HStack {
                    if tags.count > 0 {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<tags.count, id: \.self) { i in
                                    HStack {
                                        Text(tags[i].rawValue)
                                        Button {
                                            tags.remove(at: i)
                                        } label: {
                                            Image(systemName: "xmark")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .foregroundStyle(.gray)
                                                .frame(width: 8, height: 8)
                                        }
                                        .padding(.trailing, 3)
                                    }
                                    .padding(6)
                                    .background(Color(uiColor: .systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                }
                            }
                        }
                        .padding(.horizontal)
                    } else {
                        Text("Select Tags Below:")
                            .frame(width: 280, alignment: .leading)
                            .foregroundStyle(Color(uiColor: .systemGray3))
                    }
                }
                .frame(height: 50)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(EventTags.allCases, id: \.self) { i in
                                if !tags.contains(i) {
                                    Button {
                                        tags.append(i)
                                    } label: {
                                        Text(i.rawValue)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                HStack {
                    PhotosPicker(selection: $photoItems, maxSelectionCount: 3, matching: .images) {
                        Label("Add Images", systemImage: "camera")
                    }
                    Button {
                        photoItems.removeAll()
                    } label: {
                        Label("Clear Images", systemImage: "trash")
                    }
                }
                .buttonStyle(.borderedProminent)
                .onChange(of: photoItems) {
                    Task {
                        images.removeAll()
                        for i in 0..<photoItems.count {
                            if let loaded = try? await photoItems[i].loadTransferable(type: Image.self) {
                                images.append(loaded)
                            } else {
                                print("Failed")
                            }
                        }
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<photoItems.count, id: \.self) { i in
                            (i < images.count ? images[i] : Image(systemName: "photo"))
                                .resizable().aspectRatio(contentMode: .fit).frame(width: 150, height: 100).clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .padding(.horizontal)
                .frame(height: 120)
                .clipped()
                
                Button {
                    Task {
                        var imageData : [Data] = []
                        for photoItem in photoItems {
                            if let data = try? await photoItem.loadTransferable(type: Data.self) {
                                imageData.append(data)
                            }
                        }
                        let event = Event(
                            images: imageData,
                            name: name,
                            desc: desc,
                            date: date.formatDate(format: "YYYY MM dd hh:mm"),
                            location: location,
                            hosts: [])
                        EventManager.addEvent(event: event)
                    }
                } label: {
                    Text("Publish Event")
                        .bold()
                }
                .buttonStyle(.borderedProminent)
                
                Text("Add Collaborators:")
                
                Spacer()
            }
        }
    }
    func CheckValues() -> Bool {
        return !name.isEmpty &&
        !desc.isEmpty &&
        Date.now.compare(date) == .orderedAscending &&
        !location.isEmpty
    }
}
struct UserDropdownSearch : View {
    @Binding var users : [String]
    @State private var usernames: [String] = []
    @State private var filtered: [String] = []
    @State private var query : String
    @FocusState private var focused : Bool
    var body: some View {
        VStack(spacing: 0) {
            FancyTextField(text: $query, placeholder: "Search for users")
                .focused($focused)
                .onChange(of: query) {
                    filtered = usernames.filter({$0.range(of: query) != nil})
                }
            if focused {
                VStack(spacing: 0) {
                    ScrollView(showsIndicators: false) {
                        ForEach(0..<filtered.count, id: \.self) { i in
                            Text(filtered[i])
                        }
                    }
                }
                .frame(height: 70)
                .background(.white)
                .clipped()
            }
        }
        .onAppear {
            Task {
                usernames = await UserManager.fetchUsers().map({$0.username})
            }
        }
    }
}

/*
 var image: Data
 var name: String
 var desc: String
 var date: String
 var tags: [String]
 var location: String
 var hosts: [String]
 */
