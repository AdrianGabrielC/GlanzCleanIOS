//
//  SecureTextFieldComponent.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 14.08.2023.
//

import SwiftUI

struct SecureTextFieldComponent: View {
    @State var text = ""
    var placeholder: String
    var img = "lock.fill"
    
    var body: some View {
        HStack() {
            SecureField(placeholder, text: $text)
                .font(.custom("Urbanist-Regular", size: 18))
                .padding()
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "person.fill")
                .padding(.horizontal)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(.white)
        .cornerRadius(28)
        .shadow(radius: 2)
    }
}

struct SecureTextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        SecureTextFieldComponent(placeholder: "Enter your password")
    }
}
