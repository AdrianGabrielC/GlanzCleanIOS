//
//  EmployeesView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI

struct EmployeesView: View {
    @EnvironmentObject var toastManager: ToastManager
    @StateObject var employeeManager = EmployeeManager()
    @State var isLoading = false
  

    @State var showDeactivateAlert = false
    @State var showActivateAlert = false
    @State var showAlert = false
    
    @State var searchText = ""
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                HStack {
                    VStack {
                        Text("Employees")
                            .font(.custom("Urbanist-Bold", size: 28))
                        Image("EmployeesImg")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                    Spacer()
                }
                
                HStack {
                    CustomSearchBar(text: $searchText)
                        .padding(.vertical)
                    Image(systemName: "bell")
                        .font(.title2)
                        .frame(width:40, height:40)
                        .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .overlay(
                            Circle()
                                .fill(.red)
                                .frame(width:18)
                                .offset(x: 15, y:-15)
                                .overlay(
                                    Text("2")
                                        .offset(x: 15, y:-15)
                                        .font(.custom("Urbanist-Bold", size: 12))
                                )
                        )
                }
                ScrollView {
                    ForEach(employeeManager.employees) { employee in
                        NavigationLink {
                            EmployeeWorkDetailsView(employeeID: employee.id ?? UUID())
                        }label: {
                            HStack {
                                Image("ProfileImg")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:40)
                                VStack(alignment:.leading, spacing:1) {
                                    Text("\(employee.firstName ?? "") \(employee.lastName ?? "")")
                                        .font(.custom("Urbanist-Bold", size: 16))
                                        .foregroundColor(.white)
                                    HStack(spacing: 3){
                                        Circle().fill(employee.status == "active" ? .green : .red).frame(width: 10)
                                        Text("\(employee.status == "active" ? "Active" : "Inactive")")
                                            .font(.custom("Urbanist-Bold", size: 12))
                                            .foregroundColor(employee.status == "active" ? .green : .red)
                                    }
                                }
                                Spacer()
                                Image(systemName: "chevron.right").bold().foregroundColor(.white)
                            }.padding(.bottom)
                        }
                    }
                }
            }.padding().disabled(isLoading)
            if isLoading {
                LoadingView(loadingType: .download).brightness(0.5)
            }
        }
        .brightness(isLoading ? -0.5 : 0)
        .onAppear {
            isLoading = true
            employeeManager.getEmployees { response in
                isLoading = false
                if response.status == .failure {
                    toastManager.showToast(type: .failure, message: response.message)
                }
            }
        }
    }
}

struct EmployeesView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesView().environmentObject(ToastManager())
    }
}
