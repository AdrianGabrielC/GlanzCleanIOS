//
//  AddCustomerView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 20.08.2023.
//

import SwiftUI

struct AddCustomerView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var formManager = CustomerManager()
    let formatter1 = DateFormatter()
    @State var loading = false
    @State var showLocationForm = false
    @EnvironmentObject var toastManager: ToastManager
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    //Text("Add customer") .font(.custom("Urbanist-Bold", size: 24))
                    Image("AddCustomerImg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .padding(.bottom)
                    Group {
                        // First Name
                        VStack(alignment: .leading) {
                            HStack(spacing: 5) {
                                Image(systemName: "person.crop.rectangle.fill")
                                Text("Name:")
                                Spacer()
                                TextField("Enter company name", text: $formManager.name)
                                    .multilineTextAlignment(.trailing)
                                    .backgroundStyle(.red)
                            }
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                            )
                            .padding(.horizontal, 3)
                            if !formManager.isFirstNameValid {
                                Text(formManager.namePrompt)
                                    .font(.custom("Urbanist-Regular", size: 12))
                                    .foregroundColor(.red)
                                    .padding(.leading)
                            }
                        }
                        // Address
                        HStack(spacing: 5) {
                            Image(systemName: "person.crop.rectangle.fill")
                            Text("Address:")
                            Spacer()
                            TextField("Enter address", text: $formManager.address)
                                .multilineTextAlignment(.trailing)
                                .backgroundStyle(.red)
                        }
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                        )
                        .padding(.horizontal, 3)
                        
                        // Email
                        VStack(alignment:.leading) {
                            HStack(spacing: 5) {
                                Image(systemName: "envelope.fill")
                                Text("Email:")
                                Spacer()
                                TextField("Enter email", text: $formManager.email)
                                    .multilineTextAlignment(.trailing)
                                    .backgroundStyle(.red)
                            }
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                            )
                            .padding(.horizontal, 3)
                            if !formManager.emailIsValid {
                                Text(formManager.emailPrompt)
                                    .font(.custom("Urbanist-Regular", size: 12))
                                    .foregroundColor(.red)
                                    .padding(.leading)
                            }
                        }
                        
                        // Phone
                        VStack(alignment:.leading) {
                            HStack(spacing: 5) {
                                Image(systemName: "phone.fill")
                                Text("Phone:")
                                Spacer()
                                TextField("Enter phone", text: $formManager.phone)
                                    .multilineTextAlignment(.trailing)
                                    .backgroundStyle(.red)
                            }
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                            )
                            .padding(.horizontal, 3)
                            if !formManager.isPhoneValid {
                                Text(formManager.phonePrompt)
                                    .font(.custom("Urbanist-Regular", size: 12))
                                    .foregroundColor(.red)
                                    .padding(.leading)
                            }
                        }.padding(.bottom)
                        
                        // Locations
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("Locations")
                                Spacer()
                                Button {
                                    showLocationForm = true
                                }label: {
                                    Image(systemName: "plus")
                                        .font(.title2)
                                        .frame(width: 25, height: 25)
                                        .padding(5)
                                        .background(Color(red: 18/255, green: 18/255, blue: 18/255))
                                        .cornerRadius(5)
                                        .foregroundColor(.white)
                                }
                            }
                            
                            if formManager.locations.isEmpty {
                                Text("Requried. At least one location is required.")
                                    .font(.custom("Urbanist-Regular", size: 12))
                                    .foregroundColor(.red)
                            }
                            
                            ForEach(0..<formManager.locations.count, id: \.self) { index in
                                HStack {
                                    Text("\(formManager.locations[index].name), \(formManager.locations[index].address)")
                                    Spacer()
                                    Button {
                                        formManager.locations.remove(at: index)
                                        toastManager.showToast(type: .success, message: "Location successfully removed")
                                    } label: {
                                        Image(systemName: "trash").foregroundColor(.red)
                                    }
                                }
                                Divider()
                            }
                            .font(.custom("Urbanist-Regular", size: 16))
                            .padding(.top)
                        }
                        
                    }.padding(.bottom, 20)
                    Button {
                        loading = true
                        formManager.postCustomer { response in
                            loading = false
                            switch response.status {
                            case .success:
                                presentationMode.wrappedValue.dismiss()
                                toastManager.showToast(type: .success, message: response.message)
                            case .failure:
                                toastManager.showToast(type: .failure, message: response.message)
                            }
                            
                        }
                        
                    } label :{
                        Text("Save")
                            .frame(maxWidth:.infinity, maxHeight: 40)
                            .background(Color("MainYellow"))
                            .cornerRadius(10)
                            .fontDesign(.rounded)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(height: 40)
                    .disabled(formManager.isFormValid ? false : true)
                    .opacity(formManager.isFormValid ? 1 : 0.5)
                    .padding(.vertical)
                    Spacer()
                    
                }
            }
            .font(.custom("Urbanist-Bold", size: 16))
            .padding(.horizontal)
//            .navigationTitle("Personal")
//            .navigationBarTitleDisplayMode(.inline)
            .brightness(loading ? -0.5 : 0)
            .disabled(loading ? true : false)
            .sheet(isPresented: $showLocationForm) {
                VStack(alignment: .leading) {
                    // TItle
                    Text("Add new location")
                        .font(.custom("Urbanist-Bold", size: 24))
                        .padding(.bottom)
                    // Location Name
                    VStack(alignment: .leading) {
                        HStack(spacing: 5) {
                            Image(systemName: "person.crop.rectangle.fill")
                            Text("Name:")
                            Spacer()
                            TextField("Enter location name", text: $formManager.currentLocationName)
                                .multilineTextAlignment(.trailing)
                                .backgroundStyle(.red)
                        }
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                        )
                        .padding(.horizontal, 3)
                        if !formManager.isFirstNameValid {
                            Text(formManager.namePrompt)
                                .font(.custom("Urbanist-Regular", size: 12))
                                .foregroundColor(.red)
                                .padding(.leading)
                        }
                    }.padding(.bottom)
                    // Loation Address
                    HStack(spacing: 5) {
                        Image(systemName: "person.crop.rectangle.fill")
                        Text("Address:")
                        Spacer()
                        TextField("Enter address", text: $formManager.currentLocationAddress)
                            .multilineTextAlignment(.trailing)
                            .backgroundStyle(.red)
                    }
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                    )
                    .padding(.horizontal, 3)
                    .padding(.bottom)
                    
                    // Add location
                    Button {
                        if formManager.isLocationValid {
                            showLocationForm = false
                        }
                        formManager.addLocation()
                    } label :{
                        Text("Add location")
                            .frame(maxWidth:.infinity, maxHeight: 40)
                            .background(Color("MainYellow"))
                            .cornerRadius(10)
                            .fontDesign(.rounded)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(height: 40)
                    .disabled(formManager.isLocationValid ? false : true)
                    .opacity(formManager.isLocationValid ? 1 : 0.5)
                    .padding(.vertical)
                    Spacer()
                }
                .font(.custom("Urbanist-Bold", size: 16))
                .presentationDetents([.medium])
                .padding()
                .padding(.top)
                .onAppear {
                    formManager.currentLocationName = ""
                    formManager.currentLocationAddress = ""
                }
            }
            if loading {
                LoadingView(loadingType: .upload)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button {
            presentationMode.wrappedValue.dismiss()
        }label: {
            HStack {
                Image(systemName: "arrow.left.circle.fill").font(.title)
                Text("Add customer").font(.custom("Urbanist-Bold", size: 24))
            }.foregroundColor(Color("MainYellow"))
        })
    }
}

struct AddCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        AddCustomerView().environmentObject(ToastManager())
    }
}
