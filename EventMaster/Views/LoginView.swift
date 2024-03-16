//
//  LoginView.swift
//  EventMaster
//
//  Created by Max Siebengartner on 15/3/2024.
//

import Foundation
import SwiftUI

struct LoginView : View {
    
    
    @State var username: String = ""
    @State var password: String = ""
    
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
                        //login
                    } label: {
                        Text("Login")
                            .padding(.horizontal, 30)
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 10)
                    
                    HStack {
                        Rectangle().frame(width: 111, height: 1)
                            .foregroundStyle(Color(uiColor: .systemGray5))
                        Text("or").foregroundStyle(Color(uiColor: .systemGray5))
                        Rectangle().frame(width: 111, height: 1)
                            .foregroundStyle(Color(uiColor: .systemGray5))
                    }
                    .padding(.bottom, 10)
                    Button {
                        //login
                    } label: {
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
