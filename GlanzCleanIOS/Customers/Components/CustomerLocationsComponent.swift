//
//  CustomerLocationsComponent.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 23.08.2023.
//

import SwiftUI

struct CustomerLocationsComponent: View {
    @EnvironmentObject var customerManager: CustomerManager
    @EnvironmentObject var toastManager: ToastManager
    
    @State var edit = false
    @State var showDeletePopup = false
    @Binding var showAddNewLocationSheet: Bool
    
    @State var name = "Hall"
    @State var address = "Hall address"
    
    var body: some View {
        ScrollView {
            HStack {
                Text("Locations").font(.custom("Urbanist-Bold", size: 14)).foregroundColor(.gray)
                Rectangle().fill(.gray).frame(height: 1)
                Button {
                    showAddNewLocationSheet = true
                }label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            if let locations = customerManager.customerWithLocations?.locations {
                ForEach(locations, id: \.locationId) { location in
                    HStack {
                        Image(systemName: "building.2.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color(red: 70/255, green: 70/255, blue: 70/255))
                        
                        // STTAUS AND DATE
                        VStack(alignment: .leading, spacing: 10) {
                            if edit {
                                TextField("Enter location name", text: $name)
                                    .multilineTextAlignment(.leading)
                                TextField("Enter location address", text: $address)
                                    .font(.custom("Urbanist-Bold", size: 14))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                            }
                            else {
                                Text(location.name ?? "").foregroundColor(.white)
                                Text(location.address ?? "")
                                    .font(.custom("Urbanist-Bold", size: 14))
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        
                        Spacer()
                        if edit {
                            HStack {
                                Button {
                                    edit = false
                                }label: {
                                    Image(systemName: "checkmark")
                                        .font(.title2)
                                        .padding(5)
                                        .foregroundColor(.green)
                                }
                                Button {
                                    edit = false
                                }label: {
                                    Image(systemName: "multiply")
                                        .font(.title2)
                                        .padding(5)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        else {
                            Button {
                                edit = true
                                name = location.name ?? ""
                                address = location.address ?? ""
                            }label: {
                                Image(systemName: "pencil")
                                    .font(.title2)
                                    .padding(5)
                                    .foregroundColor(.gray)
                            }
                        }
                        Button {
                            print("H")
                            showDeletePopup = true
                        }label: {
                            Image(systemName: "trash")
                                .font(.title2)
                                .padding(5)
                                .foregroundColor(.red)
                        }
                        .alert("Are you sure you want to delete the location?", isPresented: $showDeletePopup) {
                            Button("OK", role :.cancel) {}
                        }
                      
                    }
                    .frame(height: 50)
                    .fontWeight(.semibold)
                    .font(.custom("Urbanist-Bold", size: 14))
                    .padding(.vertical,5)
                    //Divider().overlay(.white)
                }.padding(.leading, 20)
            }
         
        }
        .listStyle(.plain)
    }
}

struct CustomerLocationsComponent_Previews: PreviewProvider {
    static var previews: some View {
        CustomerLocationsComponent(showAddNewLocationSheet: .constant(false))
    }
}
