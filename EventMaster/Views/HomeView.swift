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
    var body: some View {
        VStack {
            LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            //Spacer()
            FancySearchField(text: $searchQuery)
                .frame(width: 320)
                .offset(y: -29)
            GeometryReader { geo in
                VStack {
                    Text("Trending")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                }
            }
            .frame(height: 520)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .background(.white)
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
