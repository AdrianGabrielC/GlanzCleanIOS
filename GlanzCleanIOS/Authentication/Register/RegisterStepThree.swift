//
//  RegisterStepThree.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 14.08.2023.
//

import SwiftUI



struct RegisterStepThree: View {
    @State var showFirstQA = false
    @State var showSecondQA = false
    
    
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
                        Image("RegisterStepThreeImg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 125)
                        HStack(spacing:0) {
                            Text("Step three")
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
                                .fill(.black)
                                .frame(width: 15, height: 2)
                            Circle()
                                .fill(.black)
                                .frame(width: 10)
                        }
                        Text("Account recovery")
                            .foregroundColor(.white)
                            .font(.custom("Urbanist-Bold", size: 24))
                    }.padding(.horizontal, 35).padding(.top, 50).padding(.bottom, 50)
                }
                Button {
                    showFirstQA = true
                }label: {
                    HStack {
                        Text("What is the name of your best friend?")
                            .font(.custom("Urbanist-Bold", size: 16))
                        Spacer()
                        Image(systemName: "chevron.down").bold()
                    }.padding()
                }.buttonStyle(.plain)
               AuthTextFieldComponent(placeholder: "Ex. Adrian")
                    .padding(.bottom)
                Button {
                    showSecondQA = true
                }label :{
                    HStack {
                        Text("What is the name of your favorite artist?")
                            .font(.custom("Urbanist-Bold", size: 16))
                        Spacer()
                        Image(systemName: "chevron.down").bold()
                    }.padding()
                }.buttonStyle(.plain)
               AuthTextFieldComponent(placeholder: "Ex. Tina Turner")
                    .padding(.bottom)
                Spacer()
                BlackButton(text: "Create account").padding(.bottom)
                
            }
            .sheet(isPresented: $showFirstQA, content: {
                QAList().presentationDetents([.medium])
            })
            .sheet(isPresented: $showSecondQA, content: {
                QAList().presentationDetents([.medium])
            })
        .padding()
        }
    }
    
    struct QAList: View {
        var isFirst = true
        var objects = [TempObj(name: "What is the name of your best friend?"), TempObj(name: "What is the name of your best friend?"), TempObj(name: "What is the name of your best friend?")]
        
        var body: some View {
            ScrollView {
                HStack {
                    Text("Pick a question").foregroundColor(.white).font(.custom("Urbanist-Semibold", size: 24)).padding(.leading).padding(.top)
                    
                    Spacer()
                }
                LazyVStack {
                    ForEach(objects) { object in
                        HStack {
                            Text(object.name)
                                .font(.custom("Urbanist-Semibold", size: 16))
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "checkmark").foregroundColor(Color(red: 143/255, green: 179/255, blue: 56/255))
                        }.padding()
                        Divider().overlay(Color(red: 208/255, green: 219/255, blue: 248/255))
                    }
                }
            }
            .padding()
            .background(.black)
        }
        
        struct TempObj: Identifiable {
            var id = UUID().uuidString
            var name:String
        }
    }
}

struct RegisterStepThree_Previews: PreviewProvider {
    static var previews: some View {
        RegisterStepThree()
    }
}



