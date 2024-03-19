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
    
    @State var userAuth : UserAuth
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
                
                FancyTextField(text: $username, placeholder: "Username", width: 260, icon: .init(systemName: "person"))
                    .padding(.bottom, 5)
                UsernameCheck(username: $username)
                    .padding(.leading, 25)
                
                FancyTextField(text: $password, placeholder: "Password", width: 260, secure: true, icon: .init(systemName: "lock"))
                    .padding(.bottom, 25)
                
                FancyTextField(text: $confirm, placeholder: "Confirm Password", width: 260, secure: true, icon: .init(systemName: "checkmark"))
                    .padding(.bottom, 25)
                
                Button {
                    if (
                        email.range(of: "([0-9]){6}@hkis.edu.hk", options: .regularExpression) != nil &&
                        username.range(of: "^([a-zA-Z0-9._]){6,20}$", options: .regularExpression) != nil &&
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
                        
                    }
                } label: {
                    Text("Sign Up")
                        .padding(.horizontal, 30)
                    
                }
                .alert("Sign Up Failed", isPresented: $showingFail) {
                    Button("OK", role: .cancel)
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
    var body: some View {
        HStack {
            Text("Must be a valid HKIS email")
                .opacity(valid ?? true ? 0 : 1)
                .padding(.leading, 25)
            Spacer()
        }
        .font(.system(size: 11))
        .foregroundStyle(Color(uiColor: .systemGray4))
        .multilineTextAlignment(.leading)
        .onChange(of: email) {
            valid = email.range(of: "([0-9]){6}@hkis.edu.hk", options: .regularExpression) != nil
        }
    }
}
