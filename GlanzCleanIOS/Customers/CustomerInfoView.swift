//
//  CustomerInfoView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 23.08.2023.
//

import SwiftUI

struct CustomerInfoView: View {
    @EnvironmentObject var toastManager: ToastManager
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var customerManager: CustomerManager
    @State var isLoading = false
    @State var searchText = ""
    @State var showAddLocationForm = false 
    var customerId: UUID
    @State var newLocationName = ""
    @State var newLocationAddress = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image("CompanyIcon")
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(customerManager.customerWithLocations?.name ?? "")").font(.custom("Urbanist-Bold", size: 24))
                            Text("\(customerManager.customerWithLocations?.address ?? "")")
                                .font(.custom("Urbanist-Bold", size: 14))
                            
                        }
                        HStack(spacing: 5) {
                            Image(systemName: "phone.fill")
                            Text("\(customerManager.customerWithLocations?.phoneNumber ?? "")")
                            Spacer()
                            Image(systemName: "envelope.fill")
                            Text("\(customerManager.customerWithLocations?.email ?? "")")
                        }.font(.custom("Urbanist-Bold", size: 14)).foregroundColor(.gray)
                    }
                    Spacer()
                }
                CustomSearchBar(text: $searchText).padding(.vertical)
                CustomerLocationsComponent(showAddNewLocationSheet: $showAddLocationForm).environmentObject(customerManager).environmentObject(toastManager)
                
            }
            .brightness(isLoading ? -0.5 : 0)
            .disabled(isLoading)
            .onAppear {
                if customerManager.customerWithLocations == nil {
                    isLoading = true
                    customerManager.getCustomerWithLocations(id: customerId) { response in
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
                            Text("Customer info") .font(.custom("Urbanist-Bold", size: 24))
                        }.foregroundColor(Color("MainYellow"))
                    }
            )
            .sheet(isPresented: $showAddLocationForm) {
                VStack(spacing: 24) {
                    // TITLE
                    HStack {
                        Text("Add new location").font(.custom("Urbanist-Bold", size: 24))
                        Spacer()
                    }
                    Divider()
                    
                    // NAME
                    VStack(alignment: .leading) {
                        HStack(spacing: 5) {
                            Image(systemName: "building.fill")
                            Text("Location name:")
                            Spacer()
                            TextField("Enter location name", text: $newLocationName)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.white)
                        }
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                        )
                        .padding(.horizontal, 3)
                    }
                    
                    // ADDRESS
                    VStack(alignment: .leading) {
                        HStack(spacing: 5) {
                            Image(systemName: "building.fill")
                            Text("Location address:")
                            Spacer()
                            TextField("Enter location address", text: $newLocationAddress)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.white)
                        }
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                        )
                        .padding(.horizontal, 3)
                    }
                    Spacer()
                    YellowButton(text: "Add location"){
                        isLoading = true
                        showAddLocationForm = false 
                        LocationService.shared.postLocation(parameters: POST.Location(name: newLocationName, address: newLocationAddress, companyId: customerId)) { response in
                            switch response.status {
                            case .success:
                                toastManager.showToast(type: .success, message: "Location successfully added!")
                                customerManager.getCustomerWithLocations(id: customerId) { response in
                                    isLoading = false
                                }
                            case .failure:
                                isLoading = false
                                toastManager.showToast(type: .failure, message: "Failed to add location!")
                            }
                        }
                    }.foregroundColor(.red)
                    
                }
                .padding()
                .font(.custom("Urbanist-Bold", size: 16))
                .foregroundColor(.gray)
                .presentationDetents([.medium])
            }
            if isLoading {
                LoadingView(loadingType: .upload)
            }
        }

    }
}

struct CustomerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerInfoView(customerId: UUID()).environmentObject(CustomerManager())
    }
}
