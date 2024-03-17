//
//  RegisterView.swift
//  EventMaster
//
//  Created by Max Siebengartner on 16/3/2024.
//

import Foundation
import SwiftUI


struct RegisterView : View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var email : String = ""
    @State var name : String = ""
    @State var surname : String = ""
    @State var username : String = ""
    @State var password : String = ""
    @State var confirm : String = ""
    
    @State var avalible : Bool? = nil
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Create Account")
                    .padding(30)
                    .font(.title)
                
                FancyTextField(text: $name, placeholder: "First Name", width: 260, icon: .init(systemName: "person"))
                    .padding(.bottom, 25)
                
                FancyTextField(text: $surname, placeholder: "Last Name", width: 260, icon: .init(systemName: "person"))
                    .padding(.bottom, 25)
                
                FancyTextField(text: $username, placeholder: "Username", width: 260, icon: .init(systemName: "person"))
                    .padding(.bottom, 5)
                
                FancyTextField(text: $password, placeholder: "Password", width: 260, secure: true, icon: .init(systemName: "lock"))
                    .padding(.bottom, 25)
                
                FancyTextField(text: $confirm, placeholder: "Confirm Password", width: 260, secure: true, icon: .init(systemName: "lock"))
                    .padding(.bottom, 25)
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Sign Up")
                        .padding(.horizontal, 30)
                    
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 10)
                
                
                
                Spacer()
            }
            .frame(width: 300, height: 450)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .clipped()
            .shadow(radius: 8)
        }
        .navigationBarBackButtonHidden(true)
        //.navigationBarItems(leading: backButton)
    }
}
