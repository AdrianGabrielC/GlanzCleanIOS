//
//  EmployeeWorkDetailsView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI

struct EmployeeModel: Codable, Identifiable, Hashable {
    var id: String
    var firstName: String
    var lastName: String
    var address: String
    var phone: String
    var email: String
    var status: String
}

struct EmployeeWorkDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    var employeeID: UUID
    @State var employee: EmployeeModel = EmployeeModel(id: "1", firstName: "Adrian", lastName: "Gabriel", address: "Fratii Catina", phone: "123456789", email: "agc@gmial.com", status: "Inactive")
    @State var loading = false
    @State var showDeactivateAlert = false
    @State var showActivateAlert = false
    @State var showAlert = false
    
    @State var searchText = ""
    
    var body: some View {
        ZStack {
            VStack(alignment:.leading, spacing: 0) {
                HStack {
                    Image("ProfileImg")
                        .resizable()
                        .frame(width:70, height:70)
                    VStack(alignment:.leading, spacing: 0) {
                        HStack(spacing: 4) {
                            Text(employee.firstName)
                            Text(employee.lastName)
                        }.font(.custom("Urbanist-Bold", size: 18))
                        HStack {
                            Circle().frame(width:10, height:10)
                            Text(employee.status)
                        }
                        .foregroundColor(employee.status == "Active" ? .green : .red)
                        .font(.custom("Urbanist-Bold", size: 12))
                    }
                    Spacer()
                }.foregroundColor(.white)
                HStack{
                    Spacer()
                    NavigationLink {
                        EmployeePersonalDetailsView(employee: $employee)
                    }label: {
                        Image(systemName: "person.text.rectangle.fill")
                            .frame(width:40, height:40)
                            .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                            .cornerRadius(10)
                    }
                    NavigationLink {
                        Text("StatisticsView()")
                    }label: {
                        Image(systemName: "chart.xyaxis.line")
                            .frame(width:40, height:40)
                            .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                            .cornerRadius(10)
                    }
                    Button {
                        if employee.status == "Active" {
                            showAlert.toggle()
                            showActivateAlert = false
                            showDeactivateAlert = true
                        }
                        else {
                            showAlert.toggle()
                            showDeactivateAlert = false
                            showActivateAlert = true
                        }
                    }label:{
                        if employee.status == "Active" {
                            Image(systemName: "multiply")
                                .font(.title2)
                                .frame(width:40, height:40)
                                .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                                .cornerRadius(10)
                                .foregroundColor(.red)
                        }
                        else {
                            Image(systemName: "power")
                                .font(.headline)
                                .frame(width:40, height:40)
                                .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                                .cornerRadius(10)
                                .foregroundColor(.green)
                        }
                    }
                    .alert(isPresented:$showAlert) {
                        Alert(
                            title: showDeactivateAlert ? Text("Are you sure you want to deactivate this user?") : Text("Are you sure you want to activate this user?"),
                            message: Text(""),
                            primaryButton: showActivateAlert ? .default(Text("Activate")) {
                                employee.status = "Active"
                                loading = true

                            } : .destructive(Text("Deactivate")) {
                                employee.status = "Inactive"
                                loading = true

                            },
                            secondaryButton: .cancel()
                        )
                    }
                }.foregroundColor(.white).padding(.bottom)
                
                CustomSearchBar(text: $searchText).padding(.bottom)
                
                //CalendarListComponent(selectedMonth: <#Binding<String>#>)
                
                Spacer()
            }
            .padding()
            .brightness(loading ? -0.5 : 0)
            .disabled(loading ? true : false)
            if loading {
                //LottieView(lottieFile: "LoadingAnimation")
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill").font(.title)
                        Text("Employee details") .font(.custom("Urbanist-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
    }
}

struct EmployeeWorkDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeWorkDetailsView(employeeID: UUID())
    }
}
