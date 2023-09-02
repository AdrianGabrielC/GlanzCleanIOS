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
    @State var client = ""
    @State var showAddClient = false
    @State var showSearchClient = false
    @State var showTypeOfWork = false
    @State var date: Date = Date()
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor = "Red"
    @State private var notes = ""
    @State var hours = 1
    @State var money = 0
    @State var pausal = false
    private var numberFormatter = NumberFormatter()
    init() {
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image("AddInvoiceImg")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.bottom, 40)
                Group {
                    Text("CLIENT")
                        .font(.callout)
                        .foregroundColor(Color(red: 115/255, green: 115/255, blue: 118/255))
                    Button {
                        showTypeOfWork.toggle()
                    } label: {
                        Text("Select client").foregroundColor(.white)
                        Spacer()
                        Text("Ninja Clean")
                        Image(systemName: "chevron.right")

                    }
                    .frame(maxWidth: .infinity, maxHeight: 30)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                    )
                    .sheet(isPresented: $showTypeOfWork) {
                        SearchClientModal()
                            .presentationDetents([.medium])
                    }
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                        )
                    DatePicker("Due Date", selection: $date, displayedComponents: .date)
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                        )
                    .padding(.bottom, 40)
                }
                Group {
                    Text("WORK DETAILS")
                        .font(.callout)
                        .foregroundColor(Color(red: 115/255, green: 115/255, blue: 118/255))
                    Button {
                        showTypeOfWork.toggle()
                    } label: {
                        Text("Select type of work").foregroundColor(.white)
                        Spacer()
                        Text("General Cleaning")
                        Image(systemName: "chevron.right")

                    }
                    .frame(maxWidth: .infinity, maxHeight: 30)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                    )
                    .sheet(isPresented: $showTypeOfWork) {
                        SearchClientModal()
                            .presentationDetents([.medium])
                    }
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                        )
                    Stepper("\(hours) hours", value: $hours, in: 1...8)
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                        )
                    HStack {
                        Image(systemName: "banknote")
                        Text("Total")
                        Spacer()
                        TextField("$0.00", value: $money, formatter: numberFormatter)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .frame(width: 80)
                            .textFieldStyle(.roundedBorder)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 30)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                    )
                    .padding(.bottom, 40)
                }
                Text("NOTES")
                    .font(.callout)
                    .foregroundColor(Color(red: 115/255, green: 115/255, blue: 118/255))
                TextEditor(text: $notes).frame(minHeight: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 115/255, green: 115/255, blue: 118/255), lineWidth: 1)
                    )
            
            }.padding(.horizontal)
        }
        .navigationTitle("Add Invoice")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InvoiceAddView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceAddView()
    }
}
