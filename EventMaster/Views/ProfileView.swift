//
//  UserDetailView.swift
//  EventMaster
//
//  Created by Max Siebengartner on 17/3/2024.
//

import Foundation
import SwiftUI

struct ProfileView : View {
    @EnvironmentObject var userAuth : UserAuth
    @State var testUser : User = User(
        name: "Max", surname: "Siebengartner", username: "Max2007", password: "Max02232007", email: "250835@hkis.edu.hk", image: UIImage(systemName: "person.circle")!.pngData()!
    )
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    ZStack {
                        Image(uiImage: UIImage(data: testUser.image)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color(uiColor: .systemGray4))
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .padding(.leading)
                        Button {
                            //open edit mode
                        } label: {
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35)
                                .background(.white)
                                .clipShape(Circle())
                                .foregroundStyle(.blue)
                                .padding()
                        }
                        .offset(x: 45, y: 45)
                        
                    }
                    VStack {
                        Text(testUser.username)
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 2)
                            .bold()
                        Text(testUser.name + " " + testUser.surname)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 12))
                            .padding(.vertical, 2)
                            .foregroundStyle(Color(uiColor: .systemGray3))
                        Text(testUser.email)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 12))
                            .padding(.vertical, 2)
                            .foregroundStyle(Color(uiColor: .systemGray3))
                        Spacer()
                    }
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.black)
                }
                .padding(.top, 70)
                .frame(height: 100)
                .padding(.bottom, 60)
                
                HStack {
                    Spacer()
                    Button("Edit Profile") {
                        
                    }
                    .padding(.leading, 50)
                    .buttonStyle(.bordered)
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear() {
            Task {
                //await userAuth.login(username: "Max123", password: "Max02232007")
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
