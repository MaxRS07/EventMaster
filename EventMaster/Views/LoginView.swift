//
//  LoginView.swift
//  EventMaster
//
//  Created by Max Siebengartner on 15/3/2024.
//

import Foundation
import SwiftUI
import FirebaseCore

struct LoginView : View {
    @EnvironmentObject var authManager : UserAuth
    
    @State var username: String = ""
    @State var password: String = ""
    
    @State var authenticated: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Text("Welcome Back")
                        .padding(30)
                        .font(.title)
                    
                    FancyTextField(text: $username, placeholder: "Username", width: 260, icon: .init(systemName: "person"))
                        .padding(.bottom, 25)
                    
                    FancyTextField(text: $password, placeholder: "Password", width: 260, secure: true, icon: .init(systemName: "lock"))
                        .padding(.bottom, 25)
                    Button {
                        Task {
                            authenticated = await authManager.login(
                                username: username,
                                password: password
                            )
                        }
                    } label: {
                        Text("Login")
                            .padding(.horizontal, 30)
                        
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Text("Incorrect username or password")
                        .foregroundStyle(.red)
                        .font(.system(size: 12))
                        .opacity(authenticated ? 0 : 1)
                        .padding(.bottom, 10)
                    HStack {
                        Rectangle().frame(width: 111, height: 1)
                            .foregroundStyle(Color(uiColor: .systemGray5))
                        Text("or").foregroundStyle(Color(uiColor: .systemGray5))
                        Rectangle().frame(width: 111, height: 1)
                            .foregroundStyle(Color(uiColor: .systemGray5))
                    }
                    .padding(.bottom, 10)
                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .padding(.horizontal, 30)
                            .padding(.vertical, 6)
                    }
                    .background(RoundedRectangle(cornerRadius: 5, style: .continuous).stroke(.tint, lineWidth: 2))
                    .padding(.bottom, 10)
                    
                    
                    Spacer()
                }
                .frame(width: 300, height: 400)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .clipped()
                .shadow(radius: 8)
            }
        }
    }
}
#Preview {
    LoginView()
}
