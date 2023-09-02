//
//  RegisterStepOne.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 14.08.2023.
//

import SwiftUI

struct RegisterStepOne: View {
    var body: some View {
        ZStack(alignment:.topLeading) {
            Color("MainYellow").ignoresSafeArea()
            
            Circle()
                .fill(.black)
                .offset(x: 250, y: 0)
                
            VStack(alignment:.leading) {
                VStack {
                    Image("RegisterStepOneImg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    HStack(spacing:0) {
                        Text("Step one")
                            .foregroundColor(.white)
                            .font(.custom("Urbanist-Bold", size: 14))
                            .padding(.trailing, 10)
                        Circle()
                            .fill(.black)
                            .frame(width: 10)
                        Rectangle()
                            .fill(.white)
                            .frame(width: 15, height: 2)
                        Circle()
                            .fill(.white)
                            .frame(width: 10)
                        Rectangle()
                            .fill(.white)
                            .frame(width: 15, height: 2)
                        Circle()
                            .fill(.white)
                            .frame(width: 10)
                    }
                    Text("Credentials")
                        .foregroundColor(.white)
                        .font(.custom("Urbanist-Bold", size: 24))
                }.padding(.horizontal, 35).padding(.top, 50).padding(.bottom, 50)
                
                // EMAIL
                HStack {
                    Image(systemName: "envelope.fill")
                    Text("Email")
                }.font(.custom("Urbanist-Bold", size: 18)).padding(.leading)
               AuthTextFieldComponent(placeholder: "Enter your email")
                    .padding(.bottom, 25)
                
                // PASSWORD
                HStack {
                    Image(systemName: "lock.fill")
                    Text("Password")
                }.font(.custom("Urbanist-Bold", size: 18)).padding(.leading)
                SecureTextFieldComponent(placeholder: "Enter your password")
                    .padding(.bottom, 25)
                
                // CONFIRM PASS
                HStack {
                    Image(systemName: "lock.fill")
                    Text("Password")
                }.font(.custom("Urbanist-Bold", size: 18)).padding(.leading)
                SecureTextFieldComponent(placeholder: "Confirm your password")
                    .padding(.bottom)
                Spacer()
                BlackButton(text: "Continue").padding(.bottom)
                
            }
            
        .padding()
        }
    }
}

struct RegisterStepOne_Previews: PreviewProvider {
    static var previews: some View {
        RegisterStepOne()
    }
}
