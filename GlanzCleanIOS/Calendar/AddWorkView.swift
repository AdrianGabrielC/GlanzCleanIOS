//
//  AddWorkView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI

struct AddWorkView: View {
    @EnvironmentObject var toastManager: ToastManager
    @Environment(\.dismiss) var dismiss
    @StateObject var formManager = CalendarManager()
    @State var showWorkType = false
    @State var showLocations = false
    @State var showCustomers = false
    @State var showEmployees = false
    @State var isLoading = false
    
    struct TempObj: Identifiable {
        var id = UUID().uuidString
        var name:String
    }
    var objects = [TempObj(name: "What is the name of your best friend?"), TempObj(name: "What is the name of your best movie?"), TempObj(name: "What is the name of your best game?")]
    
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
                        Text("Time")
                            .font(.custom("Urbanist-Bold", size: 18))
                        
                        DateFieldComponent(sfSymbolName: "calendar",
                                           placeHolder: "Date",
                                           prompt: "",
                                           field: $formManager.date,
                                           isValid: true)
                        .font(.custom("Urbanist-Semibold", size: 16))
                        .padding(.bottom, 10)
                        HourFieldComponent(sfSymbolName: "calendar",
                                           placeHolder: "Begin",
                                           prompt: "",
                                           field: $formManager.beginHour,
                                           isValid: true)
                        .font(.custom("Urbanist-Semibold", size: 16))
                        .padding(.bottom, 10)
                        HoursStepperFieldComponent(sfSymbolName: "timer",
                                              placeHolder: "Hours worked",
                                              units: "h",
                                              field: $formManager.hoursWorked)
                        .font(.custom("Urbanist-Semibold", size: 16))
                        .padding(.bottom, 10)
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
                        Text("Income")
                            .font(.custom("Urbanist-Bold", size: 18))
                            //.foregroundColor(Color(red: 115/255, green: 115/255, blue: 118/255))
                        NumberFieldComponent(sfSymbolName: "banknote",
                                             placeHolder: "Price per hour",
                                             prompt: formManager.pricePerHourPrompt,
                                             field: $formManager.pricePerHour,
                                             isValid: formManager.isPricePerHourValid)
                        .font(.custom("Urbanist-Semibold", size: 16))
                        .padding(.bottom, 10)
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
                        Text("Details")
                            .font(.custom("Urbanist-Bold", size: 18))
                        // CUSTOMER
                        Button {
                            showCustomers = true
                        }label: {
                            HStack {
                                Text(formManager.selectedCustomer == nil ? "Select customer" : formManager.selectedCustomer?.name ?? "")
                                    .font(.custom("Urbanist-Semibold", size: 16))
                                Spacer()
                                Image(systemName: "chevron.right")
                            }.foregroundColor(.white)
                        }
                        .padding(14)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        .sheet(isPresented: $showCustomers) {
                            CustomerList(isLoading: $isLoading)
                                .environmentObject(formManager)
                                .presentationDetents([.medium])
                        }
                        .padding(.bottom, 10)
                        
                        // LOCATION
                        Button {
                            showLocations = true
                        }label: {
                            HStack {
                                if let name = formManager.selectedLocation?.name, let address = formManager.selectedLocation?.address {
                                    Text("\(name), \(address)").font(.custom("Urbanist-Semibold", size: 16))
                                }
                                else {
                                    Text("Select location").font(.custom("Urbanist-Semibold", size: 16))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                            }.foregroundColor(.white)
                        }
                        .padding(14)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        .sheet(isPresented: $showLocations) {
                            LocationsList(customerId: formManager.selectedCustomer?.companyId ?? UUID(), isLoading: $isLoading)
                                .environmentObject(formManager)
                                .presentationDetents([.medium])
                        }.disabled(formManager.selectedCustomer == nil)
                        .padding(.bottom, 10)
                        // TYPE OF WORK
                        Button {
                            showWorkType = true
                        }label: {
                            HStack {
                                Text(formManager.selectedService == nil ? "Select work type" : formManager.selectedService?.name ?? "")
                                    .font(.custom("Urbanist-Semibold", size: 16))
                                Spacer()
                                Image(systemName: "chevron.right")
                            }.foregroundColor(.white)
                        }
                        .padding(14)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom, 40)
                        .sheet(isPresented: $showWorkType) {
                            ServicesList(isLoading: $isLoading)
                                .environmentObject(formManager)
                                .presentationDetents([.medium])
                        }
                    }
                    .padding(.horizontal)
                                     
                    // EMPLOYEES
                    Group {
                        HStack {
                            Text("Employees")
                                .font(.custom("Urbanist-Bold", size: 18))
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
                            .sheet(isPresented: $showEmployees) {
                                EmployeesList(isLoading: $isLoading)
                                    .environmentObject(formManager)
                                    .presentationDetents([.medium])
                            }
                        }
                        if formManager.selectedEmployees.isEmpty {
                            Text("Requried. At least one employee is required.")
                                .font(.custom("Urbanist-Regular", size: 12))
                                .foregroundColor(.red)
                        }
                        VStack {
                            LazyVStack {
                                ForEach(formManager.selectedEmployees) { employee in
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
                                        Button {
                                            formManager.selectedEmployees.removeAll(where: {$0.id == employee.id})
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
                                .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: objects.count > 0 ? 1 : 0)
                                .opacity(formManager.selectedEmployees.isEmpty ? 0 : 1)
                        )
//                        .sheet(isPresented: $showEmployees) {
//                            CustomerList()
//                                .presentationDetents([.medium])
//                        }
                        .padding(.bottom, 40)
                    }
                    .padding(.horizontal)
                    YellowButton(text: "Add work") {
                        isLoading = true
                        formManager.postWork { response in
                            isLoading = false
                            switch response.status {
                            case .success:
                                dismiss()
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
                LoadingView(loadingType: .upload).brightness(0.5)
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
        @EnvironmentObject var formManager: CalendarManager
        @State var searchText = ""
        @State var customers: [GET.CompanyShortStats] = []
        @Binding var isLoading: Bool
        
        var body: some View {
            VStack {
                CustomSearchBar(text: $searchText).padding(.top).padding(.horizontal)

                List {
                    Section(header: Text("Customers")) {
                        ForEach(customers, id:\.companyId) { customer in
                            Button{
                                formManager.selectedCustomer = customer
                            }label:{
                                HStack {
                                    Image("CompanyIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:24)
                                    VStack(alignment: .leading) {
                                        Text(customer.name ?? "")
                                            .font(.custom("Urbanist-Semibold", size: 16))
                                        Text("\(customer.name ?? "")@gmail.com")
                                            .font(.custom("Urbanist-Semibold", size: 14))
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 25, height:25)
                                        .foregroundColor(.black)
                                        .overlay(
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.green)
                                                .opacity(formManager.selectedCustomer?.name  == customer.name ? 1 : 0)
                                        )
                                }
                            }.buttonStyle(.plain)
                        }
                    }
                }
            }
            .onAppear {
                isLoading = true
                CustomerService.shared.getCustomers { companies, response in
                    if let customers = companies {
                        self.customers = customers
                    }
                    isLoading = false
                }
            }
        }
    }

    struct LocationsList: View {
        @EnvironmentObject var formManager: CalendarManager
        var customerId: UUID
        @State var searchText = ""
        @State var customerWithLocations: GET.CompanyWithLocations?
        @Binding var isLoading: Bool
        
        var body: some View {
            VStack {
                CustomSearchBar(text: $searchText).padding(.top).padding(.horizontal)
                if let locations = customerWithLocations?.locations {
                    List {
                        Section(header: Text("Locations")) {
                            ForEach(locations, id:\.locationId) { location in
                                Button{
                                    formManager.selectedLocation = location
                                }label:{
                                    HStack {
                                        Image(systemName: "building.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:24)
                                        VStack(alignment: .leading) {
                                            Text(location.name ?? "")
                                                .font(.custom("Urbanist-Semibold", size: 16))
                                            Text("\(location.address ?? "")")
                                                .font(.custom("Urbanist-Semibold", size: 14))
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        RoundedRectangle(cornerRadius: 8)
                                            .frame(width: 25, height:25)
                                            .foregroundColor(.black)
                                            .overlay(
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.green)
                                                    .opacity(formManager.selectedLocation?.locationId  == location.locationId ? 1 : 0)
                                            )
                                    }
                                }.buttonStyle(.plain)
                            }
                        }
                    }
                }
                
            }
            .onAppear {
                isLoading = true
                CustomerService.shared.getCustomerWithLocations(id: customerId) { customer, response in
                    if let customer = customer {
                        self.customerWithLocations = customer
                    }
                    isLoading = false
                }
            }
        }
    }


    struct ServicesList: View {
        @EnvironmentObject var formManager: CalendarManager
        @State var searchText = ""
        @State var services: [GET.Service] = []
        @Binding var isLoading: Bool
        
        var body: some View {
            VStack {
                CustomSearchBar(text: $searchText).padding(.top).padding(.horizontal)
                List {
                    Section(header: Text("Services")) {
                        ForEach(services, id:\.serviceId) { service in
                            Button{
                                formManager.selectedService = service
                            }label:{
                                HStack {
                                    Image(systemName: "briefcase.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:24)
                                    VStack(alignment: .leading) {
                                        Text(service.name ?? "")
                                            .font(.custom("Urbanist-Semibold", size: 16))
                                   
                                    }
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 25, height:25)
                                        .foregroundColor(.black)
                                        .overlay(
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.green)
                                                .opacity(formManager.selectedService?.serviceId  == service.serviceId ? 1 : 0)
                                        )
                                }
                            }.buttonStyle(.plain)
                        }
                    }
                }
                
            }
            .onAppear {
                isLoading = true
                ServicesService.shared.getServices { services, response in
                    if let services = services {
                        self.services = services
                    }
                    isLoading = false
                }
            }
        }
    }
    
    struct EmployeesList: View {
        @EnvironmentObject var formManager: CalendarManager
        @State var searchText = ""
        @State var employees: [GET.Employee] = []
        @Binding var isLoading: Bool
        
        var body: some View {
            VStack {
                CustomSearchBar(text: $searchText).padding(.top).padding(.horizontal)
                List {
                    Section(header: Text("Employees")) {
                        ForEach(employees, id:\.id) { employee in
                            Button{
                                if formManager.selectedEmployees.contains(where: {$0.id == employee.id}) {
                                    formManager.selectedEmployees.removeAll(where: {$0.id == employee.id})
                                }
                                else {
                                    formManager.selectedEmployees.append(employee)
                                }
                            }label:{
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
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 25, height:25)
                                        .foregroundColor(.black)
                                        .overlay(
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.green)
                                                .opacity(formManager.selectedEmployees.contains(where: {$0.id == employee.id}) ? 1 : 0)
                                        )
                                }
                            }.buttonStyle(.plain)
                        }
                    }
                }
                
            }
            .onAppear {
                isLoading = true
                EmployeeService.shared.getEmployees { employees, response in
                    if let employees = employees {
                        self.employees = employees
                    }
                    isLoading = false
                }
            }
        }
    }
}

struct AddWorkView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkView()
    }
}



