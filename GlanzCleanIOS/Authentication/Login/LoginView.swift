//
//  LoginView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 14.08.2023.
//

import SwiftUI

struct LoginView: View {
    @State var phone = ""

    
    var body: some View {
        ZStack(alignment:.topLeading) {
            //Color(red: 68/255, green: 174/255, blue: 255/255).ignoresSafeArea()
            Color("MainYellow").ignoresSafeArea()
            Circle()
                .fill(.black)
                .offset(x: -100, y: -150)
            VStack(alignment:.leading) {
                VStack {
                    Text("Welcome back")
                        .foregroundColor(.white)
                        .font(.custom("Urbanist-Regular", size: 18))
                    Text("Log In")
                        .foregroundColor(.white)
                        .font(.custom("Urbanist-Bold", size: 46))
                }.padding(50).padding(.bottom, 70)
                
               AuthTextFieldComponent(placeholder: "Enter your email")
                    .padding(.bottom)
                SecureTextFieldComponent(placeholder: "Enter your password")
                    .padding(.bottom, 30)
                BlackButton(text: "Log In")
                HStack {
                    Spacer()
                    Text("New employee?")
                        .font(.custom("Urbanist-Regular", size: 14))
                    Text("Create an account")
                        .font(.custom("Urbanist-Bold", size: 14))
                }.padding(.bottom,1)
                HStack {
                    Spacer()
                    Text("Forgot your password?")
                        .font(.custom("Urbanist-Regular", size: 14))
                        .bold()
                }.padding(.bottom, 30)
                HStack {
                    Spacer()
                    BiometricsButton(faceId: true, touchId: false, width: 300)
                    Spacer()
                }
                Spacer()
                HStack {
                    Rectangle().fill(.black).frame(height:1)
                    Text("GlanzClean").font(.custom("Urbanist-Regular", size: 14))
                    Rectangle().fill(.black).frame(height:1)
                        .overlay(
                            ZStack {
                                Capsule()
                                    .frame(width: 100, height: 200) // Adjust the size of the capsule
                                    .foregroundColor(.black)
                                
                            
                            }
                        )
                }
                
            }
            
        .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
