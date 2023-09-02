//
//  CustomerDetailsView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 20.08.2023.
//

import SwiftUI

struct CustomerDetailsView: View {
    @EnvironmentObject var toastManager: ToastManager
    @Environment(\.presentationMode) var presentationMode
    @State var searchText = ""
    var customerId: UUID
    @StateObject var customerManager = CustomerManager()
    @State var isLoading = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image("CompanyIcon")
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(customerManager.customerWithWork?.name ?? "")").font(.custom("Urbanist-Bold", size: 24))
                            Text("\(customerManager.customerWithWork?.address ?? "")")
                                .font(.custom("Urbanist-Bold", size: 14))
                            
                        }
                        HStack(spacing: 5) {
                            Image(systemName: "phone.fill")
                            Text("\(customerManager.customerWithWork?.phoneNumber ?? "")")
                            Spacer()
                            Image(systemName: "envelope.fill")
                            Text("\(customerManager.customerWithWork?.email ?? "")")
                        }.font(.custom("Urbanist-Bold", size: 14)).foregroundColor(.gray)
                    }
                    Spacer()
                }
                HStack(spacing: 10) {
                    CustomSearchBar(text: $searchText)
                    NavigationLink {
                        CustomerInfoView(customerId: customerId)
                            .environmentObject(toastManager)
                            .environmentObject(customerManager)
                    }label: {
                        Image(systemName: "person.text.rectangle.fill")
                            .frame(width:40, height:40)
                            .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    NavigationLink {
                        AddWorkForCustomerView(customerId: customerId)
                    }label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .frame(width:40, height:40)
                            .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    Image(systemName: "newspaper.fill")
                        .frame(width:40, height:40)
                        .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                        .cornerRadius(10)
                }.padding(.vertical)
                CustomerDetailsWorkListComponent()
                    .environmentObject(customerManager)
                    .environmentObject(toastManager)
                
            }
            .brightness(isLoading ? -0.5 : 0)
            .disabled(isLoading)
            .onAppear {
                if customerManager.customerWithWork == nil {
                    isLoading = true
                    customerManager.getCustomerWithWork(id: customerId) { response in
                        isLoading = false
                        if response.status == .failure {
                            presentationMode.wrappedValue.dismiss()
                            toastManager.showToast(type: .failure, message: response.message)
                        }
                    }
                }
            }
            .padding()
            .font(.custom("Urbanist-Regular", size: 16))
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        HStack {
                            Image(systemName: "arrow.left.circle.fill").font(.title)
                            Text("Customer details") .font(.custom("Urbanist-Bold", size: 24))
                        }.foregroundColor(Color("MainYellow"))
                    }
            )
            if isLoading {
                LoadingView(loadingType: .upload)
                //LottieView(lottieFile: "LoadingAnimation")
            }
        }
    }
}

struct CustomerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerDetailsView(customerId: UUID()).environmentObject(ToastManager())
    }
}
