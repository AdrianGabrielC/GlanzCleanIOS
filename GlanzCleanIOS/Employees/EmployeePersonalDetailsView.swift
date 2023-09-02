//
//  EmployeePersonalDetailsView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI

struct EmployeePersonalDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var employee: EmployeeModel
    @StateObject var formManager = EmployeeUpdateFormManager()
    let formatter1 = DateFormatter()
    @State var loading = false
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Image("EmployeeInfoImg")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                    
                    
                    Group {

                        // First Name
                        VStack(alignment: .leading) {
                            HStack(spacing: 5) {
                                Image(systemName: "person.crop.rectangle.fill")
                                Text("First Name:")
                                Spacer()
                                TextField("Enter first name", text: $formManager.firstName)
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
                                Text(formManager.firstNamePrompt).font(.footnote).foregroundColor(.red).padding(.leading)
                            }
                        }
                        // Last Name
                        VStack(alignment: .leading) {
                            HStack(spacing: 5) {
                                Image(systemName: "person.crop.rectangle.fill")
                                Text("Last Name:")
                                Spacer()
                                TextField("Enter last name", text: $formManager.lastName)
                                    .multilineTextAlignment(.trailing)
                                    .backgroundStyle(.red)
                            }
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                            )
                            .padding(.horizontal, 3)
                            if !formManager.isLastNameValid {
                                Text(formManager.lastNamePrompt).font(.footnote).foregroundColor(.red).padding(.leading)
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
                                Text(formManager.emailPrompt).font(.footnote).foregroundColor(.red).padding(.leading)
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
                                Text(formManager.phonePrompt).font(.footnote).foregroundColor(.red).padding(.leading)
                            }
                        }
                    }
                    Button {
                        loading = true
                        let updatedEmp = formManager.getNewObject()
//                        DBManager.shared.createOrUpdate(collection: "employees", data: updatedEmp) { status in
//                            ToastManager.shared.showToast(type: status, message: status == .success ? "Employee successfully added!" : "Error adding employee")
//                            employee.firstName = updatedEmp.firstName
//                            employee.lastName = updatedEmp.lastName
//                            employee.address = updatedEmp.address
//                            employee.email = updatedEmp.email
//                            employee.phone = updatedEmp.phone
//                            loading = false
//                            dismiss()
//                        }
                        
                    } label :{
                        Text("Save")
                            .frame(maxWidth:.infinity, maxHeight: 40)
                            .background(.blue)
                            .cornerRadius(10)
                            .fontDesign(.rounded)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(height: 40)
                    .disabled(formManager.isFormValid ? false : true)
                    .opacity(formManager.isFormValid ? 1 : 0.5)
                    .padding()
                    .padding(.bottom)
                    Spacer()
                    
                }
            }
            .padding(.horizontal)
            .navigationTitle("Personal")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                formManager.setValues(employee)
            }
            .brightness(loading ? -0.5 : 0)
            .disabled(loading ? true : false)
            if loading {
                ProgressView()
                //LottieView(lottieFile: "LoadingAnimation")
            }
        }
    }
}

struct EmployeePersonalDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeePersonalDetailsView(employee: .constant(EmployeeModel(id: "1", firstName: "Adrian", lastName: "Gabriel", address: "Fratii Catina", phone: "123456789", email: "agc@gmail.com", status: "Inactive")))
    }
}
