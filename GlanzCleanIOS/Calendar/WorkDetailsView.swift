//
//  WorkDetailsView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI

struct WorkDetailsView: View {
    @EnvironmentObject var toastManager: ToastManager
    var id: UUID
    var customerName: String
    @State var object: GET.WorkDetails?
    @Environment(\.dismiss) var dismiss
    @State var isLoading = false
    @State var edit = false
    @State var showRemoveAlert = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Image(object?.workStatus == "Done" ? "WorkDone" : object?.workStatus == "Canceled" ? "WorkCancelled" : object?.workStatus == "Booked" ? "WorkBooked" : object?.workStatus == "In Progress" ? "WorkInProgressV2" : "")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .padding(.bottom)
                        Circle()
                            .fill(Color("MainYellow"))
                            .frame(width: 140, height: 140)
                            .offset(x: 70, y: -40)
                    }
                    HStack {
                        Spacer()
                        Image(systemName: "newspaper.fill")
                            .frame(width:40, height:40)
                            .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                            .cornerRadius(10)
                        Button {
                            edit.toggle()
                        }label: {
                            Image(systemName: "pencil")
                                .frame(width:40, height:40)
                                .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                        Button{
                            showRemoveAlert = true
                        }label: {
                            Image(systemName: "trash")
                                .frame(width:40, height:40)
                                .background(Color(red: 41/255, green: 41/255, blue: 48/255))
                                .cornerRadius(10)
                                .foregroundColor(.red)
                        }
                        .alert("Are you sure you want to delete this work?", isPresented: $showRemoveAlert) {
                            Button("Cancel", role: .cancel) { }
                            Button("OK", role: .destructive) { }
                            }
                    }.padding(.bottom, 40)
                    
                    // WORK DETAILS
                    Group {
                        HStack{
                            Text("Customer:")
                            Spacer()
                            Text("\(customerName)").bold()
                        }
                        .font(.custom("Urbanist-Regular", size: 16))
                        .padding(.bottom)
                        
                        HStack{
                            Text("Location:")
                            Spacer()
                            Text("\(object?.location?.name ?? ""), \(object?.location?.address ?? "")").bold()
                        }
                        .font(.custom("Urbanist-Regular", size: 16))
                        .padding(.bottom)

                        HStack{
                            Text("Date:")
                            Spacer()
                            Text("\(getDate(object?.date ?? ""))").bold()
                        }
                        .font(.custom("Urbanist-Regular", size: 16))
                        .padding(.bottom)
                        
                        HStack{
                            Text("Start time:")
                            Spacer()
                            Text("\(getHour(object?.startDateTimeUtc ?? ""))").bold()
                        }
                        .font(.custom("Urbanist-Regular", size: 16))
                        .padding(.bottom)

                        HStack{
                            Text("Service:")
                            Spacer()
                            Text("\(object?.service?.name ?? "")").bold()
                        }
                        .font(.custom("Urbanist-Regular", size: 16))
                        .padding(.bottom)

                        HStack{
                            Text("Hours worked:")
                            Spacer()
                            Text("\(getDoubleFromDecimal(value: object?.hoursWorked), specifier: "%.1f") hours").bold()
                        }
                        .font(.custom("Urbanist-Regular", size: 16))
                        .padding(.bottom)

                        HStack{
                            Text("Work break:")
                            Spacer()
                            Text("\(object?.workBreak ?? 0) minutes").bold()
                        }
                        .font(.custom("Urbanist-Regular", size: 16))
                        .padding(.bottom)
                    }
                    
                    // INOME
                    Group {
                        HStack{
                            Text("Price per hour:")
                            Spacer()
                            Text("€ \(getDoubleFromDecimal(value: object?.pricePerHour), specifier: "%.2f")").bold()
                        }
                        .font(.custom("Urbanist-Regular", size: 16))
                        .padding(.bottom)

                        HStack{
                            Text("Gross income:")
                            Spacer()
                            Text("€ \(getTotalIncome(object?.pricePerHour, object?.hoursWorked), specifier: "%.2f")").bold()
                        }
                        .font(.custom("Urbanist-Regular", size: 16))
                        .padding(.bottom)
                        
                        HStack{
                            Text("Tax:")
                            Spacer()
                            Text("16 %").bold()
                        }
                        .font(.custom("Urbanist-Regular", size: 16))
                        .padding(.bottom)
                        .foregroundColor(.red)
                        
                        HStack{
                            Text("Profit:")
                            Spacer()
                            Text("€ \(getProfit(), specifier: "%.2f")").bold()
                        }
                        .font(.custom("Urbanist-Regular", size: 16))
                        .padding(.bottom)
                        .foregroundColor(.green)
                        
                        HStack {
                            Text("Employees")
                                .font(.custom("Urbanist-Regular", size: 16))
                                .foregroundColor(.white)
                            Rectangle().fill(.white).frame(maxWidth: .infinity).frame(height: 1)
                        }
                       
                        if let employees = object?.employeeWork {
                            VStack(alignment: .leading) {
                                ForEach(employees) { employee in
                                    HStack {
                                        Image("ProfileImg")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:40)
                                        VStack(alignment:.leading, spacing:5) {
                                            Text(employee.employeeName ?? "")
                                                .font(.custom("Urbanist-Bold", size: 16))
                                            HStack(spacing: 3){
                                                Circle().fill(.green).frame(width: 10)
                                                Text("Active").font(.custom("Urbanist-Bold", size: 12)).foregroundColor(.green)
                                            }
                                        }
                                        Spacer()
                                    }.padding(.bottom)
                                }
                            }.padding(.leading, 40).padding(.top).padding(.bottom, 40)
                        }
                        
                        
                    }
                    
                }.padding()
            }
            .disabled(isLoading)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button {
                       dismiss()
                    }label: {
                        HStack {
                            Image(systemName: "arrow.left.circle.fill").font(.title)
                            Text("Work details") .font(.custom("Urbanist-Bold", size: 24))
                        }.foregroundColor(Color("MainYellow"))
                    }
            )
            .task {
                isLoading = true
                WorkService.shared.getWorkDetails(id: id) { workDetails, response in
                    switch response.status {
                    case .success:
                        self.object = workDetails
                        isLoading = false
                    case .failure:
                        dismiss()
                        toastManager.showToast(type: .failure, message: "Failed to get work details!")
                    }
                }
            }
            if isLoading {
                LoadingView(loadingType: .download).brightness(0.5)
            }
        }.brightness(isLoading ? -0.5 : 0)
    }
    
    func getDoubleFromDecimal(value: Decimal?) -> Double {
        if let val = value {
            return NSDecimalNumber(decimal: val).doubleValue
        }
        return 0.0
    }
    
    func getTotalIncome(_ pricePerHour: Decimal?, _ hoursWorked: Decimal?) -> Double {
        if let pricePerHour = pricePerHour, let hoursWorked = hoursWorked {
            return NSDecimalNumber(decimal: pricePerHour).doubleValue * NSDecimalNumber(decimal: hoursWorked).doubleValue
        }
        else {
            return 0.0
        }
    }
    
    func getDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMMM dd, yyyy"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
    func getHour(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
              
              if let date = dateFormatter.date(from: dateString) {
                  let outputFormatter = DateFormatter()
                  outputFormatter.dateFormat = "HH:mm"
                  return outputFormatter.string(from: date)
              } else {
                  return "Invalid Date"
              }
      }
    
    func getProfit() -> Double {
        let total = getTotalIncome(object?.pricePerHour, object?.hoursWorked)
        return total - (total * 0.16)
    }
}

struct WorkDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkDetailsView(id: UUID(), customerName: "").environmentObject(ToastManager())
    }
}
