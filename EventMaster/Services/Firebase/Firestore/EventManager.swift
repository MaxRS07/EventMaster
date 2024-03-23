//
//  UserManager.swift
//  EventMaster
//
//  Created by Max Siebengartner on 16/3/2024.
//

import Foundation
import FirebaseFirestore

public class EventManager {
    
    private static let events = Firestore.firestore().collection("events")
    
    static func removeEvent(id: String) {
        events.document(id).delete()
    }
    static func addEvent(event: Event) {
        let userData : [String : Any] = [
            "name" : event.name,
            "desc" : event.desc,
            "images" : event.images,
            "date" : event.date,
            "hosts" : event.hosts,
            "location" : event.location,
            "tags" : event.tags
        ]
        events.addDocument(data: userData)
    }
    static func fetchEvents() async -> [Event] {
        guard let query = try? await events.getDocuments() else {return []}
        return query.documents.map({try! $0.data(as: Event.self)})
    }
    static func fetchEvent(id: String) async -> Event? {
        return try? await events.document(id).getDocument().data(as: Event.self)
    }
    static func fetchEvent(name: String) async -> Event? {
        let query = events.whereField("name", isEqualTo: name)
        return try? await query.getDocuments().documents.first?.data(as: Event.self)
    }
}

