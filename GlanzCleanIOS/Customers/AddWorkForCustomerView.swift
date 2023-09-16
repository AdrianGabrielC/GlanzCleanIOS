//
//  AddWorkForCustomerView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 27.08.2023.
//

import SwiftUI

struct AddWorkForCustomerView: View {
    @EnvironmentObject var toastManager: ToastManager
    @Environment(\.dismiss) var dismiss
    @StateObject var formManager = CalendarManager()
    @State var showWorkType = false
    @State var showLocations = false
    @State var showCustomers = false
    @State var showEmployees = false
    @State var isLoading = false
    var customerId: UUID
    @State var employees: [GET.Employee] = []
    @State var selectedEmployees: [GET.Employee] = []
    @State var searchText = ""
    
    struct TempObj: Identifiable {
        var id = UUID().uuidString
        var name:String
    }
 
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView {
                VStack(alignment:.leading) {
                    Image("AddWorkImg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .overlay(Circle().fill(Color("MainYellow")).offset(x:260))
                        .padding(.bottom, 50)
                    
                    
                    // TIME
                    Group {
                        Text("TIME")
                            .font(.custom("Urbanist-Regular", size: 18))
                            .foregroundColor(Color(red: 115/255, green: 115/255, blue: 118/255))
                        
                        DateFieldComponent(sfSymbolName: "calendar",
                                           placeHolder: "Date",
                                           prompt: "",
                                           field: $formManager.date,
                                           isValid: true)
                        .font(.custom("Urbanist-Semibold", size: 16))
                        HourFieldComponent(sfSymbolName: "calendar",
                                           placeHolder: "Begin",
                                           prompt: "",
                                           field: $formManager.beginHour,
                                           isValid: true)
                        .font(.custom("Urbanist-Semibold", size: 16))
                        HoursStepperFieldComponent(sfSymbolName: "timer",
                                              placeHolder: "Hours worked",
                                              units: "h",
                                              field: $formManager.hoursWorked)
                        .font(.custom("Urbanist-Semibold", size: 16))
                        MinutesStepperFieldComponent(sfSymbolName: "timer",
                                              placeHolder: "Work break",
                                              units: "min",
                                              field: $formManager.workBreak)
                        .font(.custom("Urbanist-Semibold", size: 16))
                        .padding(.bottom, 40)
                    }
                    .padding(.horizontal)
                    // INCOME
                    Group {
                        Text("INCOME")
                            .font(.custom("Urbanist-Regular", size: 18))
                            .foregroundColor(Color(red: 115/255, green: 115/255, blue: 118/255))
                        NumberFieldComponent(sfSymbolName: "banknote",
                                             placeHolder: "Price per hour",
                                             prompt: formManager.pricePerHourPrompt,
                                             field: $formManager.pricePerHour,
                                             isValid: formManager.isPricePerHourValid)
                        .font(.custom("Urbanist-Semibold", size: 16))
                        NumberFieldComponent(sfSymbolName: "banknote",
                                             placeHolder: "Total",
                                             prompt: "",
                                             field: $formManager.total,
                                             isValid: true)
                        .font(.custom("Urbanist-Semibold", size: 16))
                        .disabled(true)
                        .padding(.bottom, 40)
                    }
                    .padding(.horizontal)
                    // DETAILS
                    Group {
                        Text("DETAILS")
                            .font(.custom("Urbanist-Regular", size: 18))
                            .foregroundColor(Color(red: 115/255, green: 115/255, blue: 118/255))
  

                        // LOCATION
                        Button {
                            showLocations = true
                        }label: {
                            HStack {
                                Text("Select location")
                                    .font(.custom("Urbanist-Semibold", size: 16))
                                Spacer()
                                Image(systemName: "chevron.right")
                            }.foregroundColor(.white)
                        }
                        .padding(14)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        .sheet(isPresented: $showEmployees) {
                            VStack {
                                CustomSearchBar(text: $searchText).padding(.top)
                                List {
                                    Section(header: Text("Employees")) {
                                        ForEach(employees) { employee in
                                            Button{
                                                selectedEmployees.append(employee)

                                            }label:{
                                                HStack {
                                                    Text(employee.firstName ?? "")
                                                        .font(.custom("Urbanist-Semibold", size: 16))
                                                    Spacer()
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .frame(width: 25, height:25)
                                                        .foregroundColor(.black)
                                                        .overlay(
                                                            Image(systemName: "checkmark")
                                                                .foregroundColor(.green)
                                                                .opacity(selectedEmployees.contains(where: {$0.id ?? UUID() == employee.id}) ? 1 : 0)
                                                        )
                                                }
                                            }.buttonStyle(.plain)
                                        }
                                    }
                                }
                            }
                            .presentationDetents([.medium])
                        }

                        // TYPE OF WORK
                        Button {
                            showWorkType = true
                        }label: {
                            HStack {
                                Text("Seelct work type")
                                    .font(.custom("Urbanist-Semibold", size: 16))
                                Spacer()
                                Image(systemName: "chevron.right")
                            }.foregroundColor(.white)
                        }
                        .padding(14)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom, 40)
                        .sheet(isPresented: $showWorkType) {
                            WorkTypeList().presentationDetents([.medium])
                        }
                    }
                    .padding(.horizontal)
                                     
                    // EMPLOYEES
                    Group {
                        HStack {
                            Text("EMPLOYEES")
                                .font(.custom("Urbanist-Regular", size: 18))
                                .foregroundColor(Color(red: 115/255, green: 115/255, blue: 118/255))
                            Spacer()
                            Button{
                                showEmployees = true
                            }label: {
                                Image(systemName: "plus")
                                    .padding(5)
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .background(Color(red: 18/255, green: 18/255, blue: 18/255))
                                    .cornerRadius(5)
                                    .foregroundColor(.white)
                            }
                        }
                        VStack {
                            LazyVStack {
                                ForEach(selectedEmployees) { employee in
                                    HStack {
                                        Text("\(employee.firstName ?? "") \(employee.lastName ?? "")")
                                            .font(.custom("Urbanist-Semibold", size: 16))
                                            .padding()
                                        Spacer()
                                        Button {
                                            
                                        }label: {
                                            Image(systemName: "minus.circle").foregroundColor(.red)
                                        }
                                    }
                                }
                            }
                            
                        }
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: employees.count > 0 ? 1 : 0)
                        )
                        .sheet(isPresented: $showEmployees) {
                            CustomerList().presentationDetents([.medium])
                        }
                        .padding(.bottom, 40)
                    }
                    .padding(.horizontal)
                    
                    YellowButton(text:"Add work") {
                        isLoading = true
                        formManager.postWork { response in
                            isLoading = false
                            switch response.status {
                            case .success:
                                toastManager.showToast(type: .success, message: "Work successfully added!")
                            case .failure:
                                toastManager.showToast(type: .failure, message: "Failed to add work!")
                            }
                        }
                    }
                    //.disabled(formManager.isFormValid ? false : true)
                    //.opacity(formManager.isFormValid ? 1 : 0.5)
                    .padding()
                    .padding(.bottom)
                    Spacer()
                }
            }.disabled(isLoading)
            if isLoading {
                LoadingView(loadingType: .download).brightness(0.5)
            }
        }
        .brightness(isLoading ? -0.5 : 0)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    dismiss()
                }label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill").font(.title)
                        Text("Add work") .font(.custom("Urbanist-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
    }
    
    struct CustomerList: View {
        var objects = [TempObj(name: "What is the name of your best friend?"), TempObj(name: "What is the name of your best movie?"), TempObj(name: "What is the name of your best game?")]
        @State var selectedObject = TempObj(name: "What is the name of your best friend?")
        @State var searchText = ""
        
        var body: some View {
            VStack {
                CustomSearchBar(text: $searchText).padding(.top)

                List {
                    Section(header: Text("Customers")) {
                        ForEach(objects) { object in
                            Button{
                                selectedObject = object
                            }label:{
                                HStack {
                                    Text(object.name)
                                        .font(.custom("Urbanist-Semibold", size: 16))
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 25, height:25)
                                        .foregroundColor(.black)
                                        .overlay(
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.green)
                                                .opacity(selectedObject.name == object.name ? 1 : 0)
                                        )
                                }
                            }.buttonStyle(.plain)
                        }
                    }
                }
            }

        }
        
        struct TempObj: Identifiable {
            var id = UUID().uuidString
            var name:String
        }
    }

    struct LocationsList: View {
        var body: some View {
            Text("A")
        }
    }


    struct WorkTypeList: View {
        var body: some View {
            Text("A")
        }
    }
}

struct AddWorkForCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkForCustomerView(customerId: UUID())
    }
}
