//
//  ContentView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 14.08.2023.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var isLoggedIn = true
    @StateObject var toastManager = ToastManager()
    
    var body: some View {
        if isLoggedIn {
            TabView {
                NavigationStack {
                    CalendarView().environmentObject(toastManager)
                }
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
                NavigationStack {
                    EmployeesView().environmentObject(toastManager)
                }
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Employees")
                }
                NavigationStack {
                    CustomersView().environmentObject(toastManager)
                  
                }
                .tabItem {
                    Image(systemName: "building")
                    Text("Customers")
                }
                NavigationStack {
                    InvoiceView().environmentObject(toastManager)
                }
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("Invoices")
                }
            }.overlay(Toast().environmentObject(toastManager))
        }
        else {
            LoginView()
             
//                .onAppear {
//                    let url = "https://glanzclean.azurewebsites.net/api/services" // Replace with your API endpoint
//                    print("REQ")
//                    AF.request(url, method: .get)
//                        .responseJSON { res in
//                            print(res)
//                        }
//                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
