//
//  RegisterStepTwo.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 14.08.2023.
//

import SwiftUI

struct RegisterStepTwo: View {
    @State private var birthDate = Date.now
    
    var body: some View {
        ZStack(alignment:.topLeading) {
            Color("MainYellow").ignoresSafeArea()
            Circle()
                .fill(.black)
                .frame(width: 250)
                .offset(x: -120, y: 0)
                
            VStack(alignment:.leading) {
                HStack {
                    Spacer()
                    VStack {
                        Image("RegisterStepTwoImg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 125)
                        HStack(spacing:0) {
                            Text("Step two")
                                .foregroundColor(.white)
                                .font(.custom("Urbanist-Bold", size: 14))
                                .padding(.trailing, 10)
                            Circle()
                                .fill(.black)
                                .frame(width: 10)
                            Rectangle()
                                .fill(.black)
                                .frame(width: 15, height: 2)
                            Circle()
                                .fill(.black)
                                .frame(width: 10)
                            Rectangle()
                                .fill(.white)
                                .frame(width: 15, height: 2)
                            Circle()
                                .fill(.white)
                                .frame(width: 10)
                        }
                        Text("Personal data")
                            .foregroundColor(.white)
                            .font(.custom("Urbanist-Bold", size: 24))
                    }.padding(.horizontal, 35).padding(.top, 50).padding(.bottom, 50)
                }
                
                // FIRST NAME
                HStack {
                    Image(systemName: "person.fill")
                    Text("First name")
                }.font(.custom("Urbanist-Bold", size: 18)).padding(.leading)
               AuthTextFieldComponent(placeholder: "Enter your first name")
                    .padding(.bottom, 25)
                
                // LAST NAME
                HStack {
                    Image(systemName: "person.fill")
                    Text("Last name")
                }.font(.custom("Urbanist-Bold", size: 18)).padding(.leading)
               AuthTextFieldComponent(placeholder: "Enter your last name")
                    .padding(.bottom, 25)
                
                // DATE
                HStack {
                    Image(systemName: "calendar.circle.fill")
                    Text("Employment start date")
                }.font(.custom("Urbanist-Bold", size: 18)).padding(.leading)
                HStack{
                    Text("Enter start date").foregroundColor(Color(red: 204/255, green: 204/255, blue: 206/255))
                        .font(.custom("Urbanist-Regular", size: 18))
                    Spacer()
                    DatePicker(selection: $birthDate, displayedComponents: .date) {
                        Text("").font(.custom("Urbanist-Bold", size: 14))
                    }
                    .font(.custom("Urbanist-Bold", size: 18))
                    .padding(.leading)
                }
                .padding()
                .background(.white)
                .cornerRadius(28)
                .frame(maxWidth: .infinity)
              
                Spacer()
                BlackButton(text: "Continue").padding(.bottom)
                
            }
            
        .padding()
        }
    }
}

struct RegisterStepTwo_Previews: PreviewProvider {
    static var previews: some View {
        RegisterStepTwo()
    }
}
