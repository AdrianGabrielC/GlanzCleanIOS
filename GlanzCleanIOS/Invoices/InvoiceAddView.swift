//
//  InvoiceAddView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI

struct SearchClientModal: View {
    var body: some View {
        Text("H")
    }
}

struct InvoiceAddView: View {
    @EnvironmentObject var toastManager: ToastManager
    @Environment(\.presentationMode) var presentationMode
    @State var existingWork:Int = 1
    @State var work: [GET.WorkSummary] = []
    
    func getDoubleFromDecimal(value: Decimal?) -> Double {
        if let val = value {
            return NSDecimalNumber(decimal: val).doubleValue
        }
        return 0.0
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image("AddInvoiceImg")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.bottom, 40)
                    .padding(.top)
             
                Picker("", selection: $existingWork) {
                    Text("Existing work").tag(1)
                    Text("New work").tag(0)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom)
                
                if existingWork == 1 {
                    ScrollView {
                        if work.isEmpty {
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
                            ForEach(work) { work in
                                NavigationLink {
                                    NewInvoiceDetailsView().environmentObject(toastManager)
                                } label: {
                                    HStack {
                                        Image(work.workStatus?.lowercased() == "done" ? "WorkDone" : work.workStatus?.lowercased() == "canceled" ? "WorkCancelled" : work.workStatus?.lowercased() == "booked" ? "WorkBooked" : work.workStatus?.lowercased() == "in progress" ? "WorkInProgressV2" : "")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 50)
                                        
                                        // STTAUS AND DATE
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text(work.workStatus ?? "").foregroundColor(work.workStatus?.lowercased() == "done" ? Color(red: 0/255, green: 191/255, blue: 120/255) : work.workStatus == "Canceled" ? Color(red: 245/255, green: 8/255, blue: 92/255) : work.workStatus == "In Progress" ? Color(red: 82/255, green: 109/255, blue: 254/255) : work.workStatus == "Booked" ?  Color(red: 193/255, green: 204/255, blue: 206/255) : .white)
                                            Text("\(DateUtil.shared.getPrettyDateString(work.date ?? "") ?? "")").font(.custom("Urbanist-Bold", size: 14)).foregroundColor(.gray)
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
                                            Text("€ \(getDoubleFromDecimal(value: work.totalIncome), specifier: "%.2f")").foregroundColor(work.workStatus?.lowercased() == "done" ? Color(red: 0/255, green: 191/255, blue: 120/255) : work.workStatus == "Canceled" ? Color(red: 245/255, green: 8/255, blue: 92/255) : work.workStatus == "In Progress" ? Color(red: 82/255, green: 109/255, blue: 254/255) : work.workStatus == "Booked" ?  Color(red: 193/255, green: 204/255, blue: 206/255) : .white)
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
                            }
                        }
                        
                    }
                    .listStyle(.plain)
                }
            
            }.padding(.horizontal)
        }
        .task {
            WorkService.shared.getWork(year: 2023, month: nil, day: nil) { work, response in
                if let work = work {
                    self.work = work
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button {
            presentationMode.wrappedValue.dismiss()
        }label: {
            HStack {
                Image(systemName: "arrow.left.circle.fill").font(.title)
                Text("Add invoice").font(.custom("Urbanist-Bold", size: 24))
            }.foregroundColor(Color("MainYellow"))
        })
    }
}

struct InvoiceAddView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceAddView()
    }
}
