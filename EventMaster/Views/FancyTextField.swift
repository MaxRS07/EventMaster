//
//  FancyTextField.swift
//  EventMaster
//
//  Created by Max Siebengartner on 15/3/2024.
//

import Foundation
import SwiftUI

struct FancyTextField : View {
    
    @Binding var text: String
    @State var placeholder: String
    @State var width: CGFloat = 300
    
    @State var secure: Bool = false
    @FocusState private var focused : Bool
    
    @State var icon: UIImage?
    
    @State private var editing : Bool = false
    
    var body: some View {
        VStack {
            HStack {
                if secure {
                    SecureField(placeholder, text: $text)
                        .frame(width: width - (icon == nil ? 20 : 40))
                } else {
                    TextField(placeholder, text: $text)
                        .frame(width: width - (icon == nil ? 20 : 40))
                }
                if icon != nil {
                   Image(uiImage: icon!)
                }
            }
            Divider()
                .overlay(Rectangle().frame(width: editing ? width : 0, height: 1).foregroundStyle(.blue))
                .frame(width: width)
        }
        .focused($focused)
        .onChange(of: focused) {
            withAnimation(.easeInOut) {
                editing = focused
            }
        }
        .textInputAutocapitalization(.never)
    }
}

