//
//  CustomerDetailsWorkListComponent.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 20.08.2023.
//

import SwiftUI

struct CustomerDetailsWorkListComponent: View {
    @EnvironmentObject var customerManager: CustomerManager
    @EnvironmentObject var toastManager: ToastManager
    
    var body: some View {
        ScrollView {
//            HStack {
//                Text("February").font(.custom("Urbanist-Bold", size: 14)).foregroundColor(.gray)
//                Rectangle().fill(.gray).frame(height: 1)
//            }
            if let work = customerManager.customerWithWork?.work {
                ForEach(0..<CustomerManager.Month.allCases.count, id: \.self) { index in
                    if customerManager.booleanMonthArr[index] {
                        HStack {
                            Text(CustomerManager.Month(rawValue: index + 1)?.monthName ?? "")
                                .font(.custom("Urbanist-Bold", size: 14))
                                .foregroundColor(.gray)
                            Rectangle().fill(.gray).frame(height: 1)
                        }
                        ForEach(work) { work in
                            if customerManager.getMonthIndexFromDateString(work.date ?? "") == index {
                                NavigationLink {
                                    WorkDetailsView(id: work.id ?? UUID(), customerName: customerManager.customerWithWork?.name ?? "" )
                                        .environmentObject(toastManager)
                                } label: {
                                    VStack {
                                        HStack {
                                            Image(work.workStatus?.lowercased() == "done" ? "WorkDone" : work.workStatus == "Canceled" ? "WorkCancelled" : work.workStatus == "Booked" ? "WorkBooked" : work.workStatus == "In Progress" ? "WorkInProgressV2" : "")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(maxWidth: 50)
                                            
                                            // STTAUS AND DATE
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text(work.workStatus ?? "").foregroundColor(work.workStatus?.lowercased() == "done" ? Color(red: 0/255, green: 191/255, blue: 120/255) : work.workStatus == "Canceled" ? Color(red: 245/255, green: 8/255, blue: 92/255) : work.workStatus == "In Progress" ? Color(red: 82/255, green: 109/255, blue: 254/255) : work.workStatus == "Booked" ?  Color(red: 193/255, green: 204/255, blue: 206/255) : .white)
                                                Text("\(customerManager.getPrettyDate(work.date ?? ""))").font(.custom("Urbanist-Bold", size: 14)).foregroundColor(.gray)
                                            }
                                            
                                            // LOCATION AND SERVICE
                                            Spacer()
                                            VStack(alignment: .center, spacing: 10) {
                                                Text(work.locationName ??  "")
                                                Text(work.serviceName ?? "")
                                            }.foregroundColor(.gray)
                                            
                                            // INCOME AND ACCEPTED
                                            Spacer()
                                            VStack(alignment: .trailing, spacing: 10) {
                                                Text("€ \(customerManager.getDoubleFromDecimal(value: work.totalIncome), specifier: "%.2f")").foregroundColor(work.workStatus?.lowercased() == "Done" ? Color(red: 0/255, green: 191/255, blue: 120/255) : work.workStatus == "Canceled" ? Color(red: 245/255, green: 8/255, blue: 92/255) : work.workStatus == "In Progress" ? Color(red: 82/255, green: 109/255, blue: 254/255) : work.workStatus == "Booked" ?  Color(red: 193/255, green: 204/255, blue: 206/255) : .white)
                                                if work.accepted ?? true {
                                                    Image(systemName: "checkmark").foregroundColor(.green).bold()
                                                }
                                                else {
                                                    Image(systemName: "multiply").foregroundColor(.red).bold()
                                                }
                                            }
                                        }
                                        .frame(height: 50)
                                        .fontWeight(.semibold)
                                        .font(.custom("Urbanist-Bold", size: 14))
                                    .padding(.vertical,5)
                                        //Divider().overlay(.white)
                                    }
                                    
                                }
                            }
                        }.padding(.leading, 20)
                    }
                }

            }
            
            
            
            
         
            
        }
        .listStyle(.plain)
    }
}

struct CustomerDetailsWorkListComponent_Previews: PreviewProvider {
    static var previews: some View {
        CustomerDetailsWorkListComponent().environmentObject(CustomerManager())
    }
}
