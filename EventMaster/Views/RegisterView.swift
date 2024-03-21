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
    
    @EnvironmentObject var userAuth : UserAuth
    @State var email : String = ""
    @State var username : String = ""
    @State var password : String = ""
    @State var confirm : String = ""
    
    @State var avalible : Bool? = nil
    @State var showingFail : Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundStyle(Color(uiColor: .systemBlue))
                    }
                    Text("Create Account")
                        .padding([.bottom, .trailing, .top], 30)
                        .font(.title)
                }
                
                FancyTextField(text: $email, placeholder: "Email", width: 260, icon: .init(systemName: "envelope"))
                    .padding(.bottom, 5)
                EmailCheck(email: $email)
                    .padding(.bottom, 3)
                
                FancyTextField(text: $username, placeholder: "Username", width: 260, icon: .init(systemName: "person"))
                    .padding(.bottom, 5)
                UsernameCheck(username: $username)
                    .padding(.leading, 25)
                
                FancyTextField(text: $password, placeholder: "Password", width: 260, secure: true, icon: .init(systemName: "lock"))
                    .padding(.bottom, 25)
                
                FancyTextField(text: $confirm, placeholder: "Confirm Password", width: 260, secure: true, icon: .init(systemName: "checkmark"))
                    .padding(.bottom, 25)
                
                Button {
                    Task {
                        let usernameAvalible = await UserManager.fetchUser(username: username) == nil
                        let emailAvalible = await UserManager.fetchUser(email: email) == nil
                        if (
                            email.range(of: "([0-9]){6}@hkis.edu.hk", options: .regularExpression) != nil &&
                            emailAvalible &&
                            username.range(of: "^([a-zA-Z0-9._]){6,20}$", options: .regularExpression) != nil &&
                            usernameAvalible &&
                            password.count >= 8 &&
                            confirm == password
                        ) {
                            UserManager.addUser(user:
                                                    User(name: "",
                                                         surname: "",
                                                         username: username,
                                                         password: password,
                                                         email: email)
                            )
                            Task {
                                showingFail = await userAuth.login(
                                    username: username,
                                    password: password
                                )
                            }
                            
                        } else {
                            if password.count < 8 {
                                
                            }
                            if confirm != password {
                                
                            }
                            if email.range(of: "([0-9]){6}@hkis.edu.hk", options: .regularExpression) == nil {
                                
                            }
                            if username.range(of: "^([a-zA-Z0-9._]){6,20}$", options: .regularExpression) == nil {
                                
                            }
                        }
                    }
                } label: {
                    Text("Sign Up")
                        .padding(.horizontal, 30)
                    
                }
                .alert("Sign Up Failed", isPresented: $showingFail) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("Something went wrong. Try again later")
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
struct EmailCheck : View {
    @Binding var email : String
    @State private var valid: Bool? = nil
    @State private var error: String = ""
    var body: some View {
        HStack {
            Text(error)
                .opacity(valid ?? true ? 0 : 1)
                .foregroundStyle(.red)
                .padding(.leading, 25)
            Spacer()
        }
        .font(.system(size: 11))
        .foregroundStyle(Color(uiColor: .systemGray4))
        .multilineTextAlignment(.leading)
        .onChange(of: email) {
            Task {
                valid = email.range(of: "([0-9]){6}@hkis.edu.hk", options: .regularExpression) != nil
                if !valid! {
                    error = "Must be a valid HKIS email"
                }
                if await UserManager.fetchUser(email: email) != nil {
                    error = "Email already registered"
                    valid = false
                }
            }
        }
    }
}
#Preview {
    RegisterView()
}
