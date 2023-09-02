//
//  CustomersView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 20.08.2023.
//

import SwiftUI

struct CustomersView: View {
    @EnvironmentObject var toastManager: ToastManager
    @StateObject var customerManager = CustomerManager()
    @State var loading = false
    @State var showDeactivateAlert = false
    @State var showActivateAlert = false
    @State var showAlert = false
      
    @State var searchText = ""
      
      var body: some View {
          ZStack {
              Color.black.ignoresSafeArea()
              VStack(spacing:0) {
                  HStack {
                      HStack {
                          Image("CustomersImg")
                              .resizable()
                              .scaledToFit()
                              .frame(height: 150)
                              .offset(y: -30)
                          Circle()
                              .fill(Color("MainYellow"))
                              .frame(width: 75, height: 75)
                              .offset(y:-50)
                          Circle()
                              .trim(from: 0, to: 0.5)
                              .fill(Color("MainYellow"))
                              .frame(width: 75, height: 75)
                      }
                      Spacer()
                  }
                  
                  HStack {
                      CustomSearchBar(text: $searchText)
                          .padding(.vertical)
                      NavigationLink {
                          AddCustomerView().environmentObject(toastManager)
                      }label: {
                          Image(systemName: "plus")
                              .font(.title2)
                              .frame(width:40, height:40)
                              .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                              .cornerRadius(10)
                              .foregroundColor(.white)
                      }
                  }
                  if customerManager.companies.isEmpty {
                      if loading == false {
                          Text("No companies found")
                              .font(.custom("Urbanist-Bold", size: 24))
                              .padding(.vertical)
                          Image("NoDataImg")
                              .resizable()
                              .scaledToFit()
                              .frame(width: 200)
                      }
                  }
                  else {
                      ScrollView {
                          ForEach(customerManager.companies, id:\.self.companyId) { customer in
                              NavigationLink {
                                  CustomerDetailsView(customerId: customer.companyId ?? UUID()).environmentObject(toastManager)
                              }label: {
                                  HStack {
                                      Image("CompanyIcon")
                                          .resizable()
                                          .scaledToFit()
                                          .frame(width:40)
                                      VStack(alignment:.leading, spacing:1) {
                                          HStack {
                                              VStack(alignment: .leading) {
                                                  Text("\(customer.name ?? "BRD")")
                                                      .font(.custom("Urbanist-Bold", size: 16))
                                                  if let numberOfLocations = customer.numberOfLocations {
                                                      Text("\(numberOfLocations) locations")
                                                          .font(.custom("Urbanist-Bold", size: 12))
                                                          .foregroundColor(.gray)
                                                  }
                                                  else {
                                                      ProgressView()
                                                  }
                                              }
                                              Spacer()
                                              VStack(alignment: .trailing) {
                                                  Text("€ \(customerManager.getDoubleFromDecimal(value: customer.totalIncome), specifier: "%.2f")")
                                                      .font(.custom("Urbanist-Bold", size: 12))
                                                      .foregroundColor(.green)
                                                  if let numberOfTasks = customer.numberOfTasks {
                                                      Text("\(numberOfTasks) tasks").font(.custom("Urbanist-Bold", size: 12)).foregroundColor(.gray)
                                                  }
                                                  else {
                                                      ProgressView()
                                                  }
                                              }
                                          }
                                         
                                      }
                                      Spacer()
                                      Image(systemName: "chevron.right").bold()
                                  }.padding(.bottom)
                              }.foregroundColor(.white)
                          }
                      }
                  }
                  Spacer()
              }.padding()
              if loading {
                  LoadingView(loadingType: .download).brightness(0.5)
              }
          }
          .brightness(loading ? -0.5 : 0)
          .onAppear {
              loading = true
              customerManager.getCustomers { response in
                  loading = false
                  if response.status == .failure {
                      toastManager.showToast(type: .failure, message: response.message)
                  }
              }
          }
          .navigationBarTitleDisplayMode(.large)
          .navigationTitle("Customers")
      }
}

struct CustomersView_Previews: PreviewProvider {
    static var previews: some View {
        CustomersView().environmentObject(ToastManager())
    }
}
