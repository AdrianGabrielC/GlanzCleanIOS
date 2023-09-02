//
//  CalendarListComponent.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI



struct CalendarListComponent: View {
    @EnvironmentObject var calendarManager: CalendarManager
    @Binding var selectedMonth: Int

    
    var body: some View {
        ScrollView {
            if calendarManager.work.isEmpty {
                Image("NoDataImg")
                    .resizable()
                    .scaledToFit()
                    .padding()
                HStack{
                    Spacer()
                    Text("No work found!").font(.custom("Urbanist-Bold", size: 24)).foregroundColor(.gray).padding()
                    Spacer()
                }
            }
            else {
                ForEach(calendarManager.work.filter { calendarManager.getMonthIntFromDateString($0.date ?? "") == selectedMonth}) { work in
                    NavigationLink {
                        WorkDetailsView(id: work.id ?? UUID(), customerName: "ASD")
                    } label: {
                        HStack {
                            Image(work.workStatus?.lowercased() == "done" ? "WorkDone" : work.workStatus?.lowercased() == "canceled" ? "WorkCancelled" : work.workStatus?.lowercased() == "booked" ? "WorkBooked" : work.workStatus?.lowercased() == "in progress" ? "WorkInProgressV2" : "")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 50)
                            
                            // STTAUS AND DATE
                            VStack(alignment: .leading, spacing: 10) {
                                Text(work.workStatus ?? "").foregroundColor(work.workStatus == "Done" ? Color(red: 0/255, green: 191/255, blue: 120/255) : work.workStatus == "Canceled" ? Color(red: 245/255, green: 8/255, blue: 92/255) : work.workStatus == "In Progress" ? Color(red: 82/255, green: 109/255, blue: 254/255) : work.workStatus == "Booked" ?  Color(red: 193/255, green: 204/255, blue: 206/255) : .white)
                                Text("\(calendarManager.getPrettyDateString(work.date ?? "") ?? "")").font(.custom("Urbanist-Bold", size: 14)).foregroundColor(.gray)
                            }
                            
                            // LOCATION AND SERVICE
                            Spacer()
                            VStack(alignment: .center, spacing: 10) {
                                Text(work.companyName ??  "")
                                Text(work.serviceName ?? "")
                            }.foregroundColor(.gray)
                            
                            // INCOME AND ACCEPTED
                            Spacer()
                            VStack(alignment: .trailing, spacing: 10) {
                                Text("€ \(calendarManager.getDoubleFromDecimal(value: work.totalIncome), specifier: "%.2f")").foregroundColor(work.workStatus == "Done" ? Color(red: 0/255, green: 191/255, blue: 120/255) : work.workStatus == "Canceled" ? Color(red: 245/255, green: 8/255, blue: 92/255) : work.workStatus == "In Progress" ? Color(red: 82/255, green: 109/255, blue: 254/255) : work.workStatus == "Booked" ?  Color(red: 193/255, green: 204/255, blue: 206/255) : .white)
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
                    }
                    Divider()
                }.padding(.leading, 20)
            }
            
        }
        .listStyle(.plain)
    }
}

struct CalendarListComponent_Previews: PreviewProvider {
    static var previews: some View {
        CalendarListComponent( selectedMonth: .constant(1)).environmentObject(CalendarManager())
    }
}
