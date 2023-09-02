//
//  TextFieldComponent.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 14.08.2023.
//

import SwiftUI

enum FormFieldType {
    case textField
    case secureTextField
    case date
    case picker
    case checkbox
    case toggle
    
}

struct AuthTextFieldComponent: View {
    @State var text = ""
    var placeholder: String
    var img = "person.fill"
    
    var body: some View {
        HStack() {
            TextField(placeholder, text: $text)
                .font(.custom("Urbanist-Regular", size: 18))
                .padding()
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "person.fill")
                .padding(.horizontal)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(.white)
        .cornerRadius(28)
        .shadow(radius: 2)
    }
}

struct BlackTextFieldComponent: View {
    var sfSymbolName: String
    var placeHolder: String
    var prompt: String
    @Binding var field: String
    var isSecure:Bool = false
    var isValid: Bool
    var type: FormFieldType
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: sfSymbolName)
                    .foregroundColor(.gray)
                    .font(.headline)
                switch type {
                case .textField:
                    TextField(placeHolder, text: $field).autocapitalization(.none)
                default:
                    SecureField(placeHolder, text: $field).autocapitalization(.none)
                }
            }
            .padding(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            Text(prompt)
            .fixedSize(horizontal: false, vertical: true)
            .font(.caption)
            .foregroundColor(isValid ? .gray : .red)
        }
    }
}

struct HourFieldComponent: View {
    var sfSymbolName: String
    var placeHolder: String
    var prompt: String
    @Binding var field: Date
    var isSecure:Bool = false
    var isValid: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            DatePicker(selection: $field, in: ...Date.now, displayedComponents: .hourAndMinute) {
                HStack {
                    Image(systemName: "calendar")
                    Text(placeHolder)
                }
            }
            .padding(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            if !isValid {
                Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
                .foregroundColor(isValid ? .gray : .red)
            }
        }
    }
}



struct MinutesStepperFieldComponent: View {
    var sfSymbolName: String
    var placeHolder: String
    var units: String
    @Binding var field: Int
    
    var body: some View {
        HStack {
            Image(systemName: sfSymbolName)
            Stepper("\(placeHolder): \(field) \(units)", onIncrement: {
                field += 15
            }, onDecrement: {
                if field - 15 >= 0 {
                    field -= 15
                }
            })
        }
        .padding(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
    }
}

struct HoursStepperFieldComponent: View {
    var sfSymbolName: String
    var placeHolder: String
    var units: String
    @Binding var field: Int
    
    var body: some View {
        HStack {
            Image(systemName: sfSymbolName)
            Stepper("\(placeHolder): \(field) \(units)", onIncrement: {
                field += 1
            }, onDecrement: {
                if field - 1 >= 0 {
                    field -= 1
                }
            })
        }
        .padding(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
    }
}

struct NumberFieldComponent: View {
    var sfSymbolName: String
    var placeHolder: String
    var prompt: String
    @Binding var field: Double
    var isValid: Bool
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: sfSymbolName)
                Text(placeHolder)
                Spacer()
                TextField("$0.00", value: $field, formatter: formatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            if !isValid {
                Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
                .foregroundColor(isValid ? .gray : .red)
            }
        }
    }
}


enum SelectFieldComponentTypes {
    case customer
    case location
    case typeOfWork
}
struct SelectFieldComponent: View {
    var sfSymbolName: String
    var title: String
    var value: String
    @Binding var field: String
    @State var show = false
    var type: SelectFieldComponentTypes
    @State var searchText = ""

    var body: some View {
        VStack(alignment: .leading) {
            Button {
                show = true
            }label: {
                HStack {
                    Text(title)
                    Spacer()
                    Text(value)
                    Image(systemName: "chevron.right")
                }.foregroundColor(.white)
            }
            .sheet(isPresented: $show) {
                switch type {
                case .location:
                    VStack {
                        HStack {
                            CustomSearchBar(text: $searchText)
                            Spacer()
                            Button{
                                
                            }label: {
                                Image(systemName: "plus")
                                    .padding(10)
                                    .background(.black)
                                    .bold()
                                    .cornerRadius(5)
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        List {
                            Section(header: Text("locations")) {
                                Text("Kindergarden")
                                Text("BRD")
                                Text("Hall")
                                Text("Townhall")
                                Text("Office")
                                Text("Kindergarden")
                                Text("BRD")
                                Text("Hall")
                                Text("Townhall")
                                Text("Office")
                            }
                        }
                        .presentationDetents([.medium])
                    }
                case .customer:
                    VStack {
                        HStack {
                            CustomSearchBar(text: $searchText)
                            Spacer()
                            Button{
                                
                            }label: {
                                Image(systemName: "plus")
                                    .padding(10)
                                    .background(.black)
                                    .bold()
                                    .cornerRadius(5)
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        List {
                            Section(header: Text("customers")) {
                                Text("Ninja clean")
                                Text("Albanezu")
                                Text("Ninja clean")
                                Text("Albanezu")
                                Text("Ninja clean")
                                Text("Albanezu")
                                Text("Ninja clean")
                                Text("Albanezu")
                                Text("Ninja clean")
                                Text("Albanezu")
                            }
                        }
                        .presentationDetents([.medium])
                    }
                case .typeOfWork:
                    VStack {
                        HStack {
                            CustomSearchBar(text: $searchText)
                            Spacer()
                            Button{
                                
                            }label: {
                                Image(systemName: "plus")
                                    .padding(10)
                                    .background(.black)
                                    .bold()
                                    .cornerRadius(5)
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        List {
                            Section(header: Text("type")) {
                                Text("General Cleaning")
                                Text("Windows")
                                Text("Floor")
                                Text("Solar panel")
                                Text("General Cleaning")
                                Text("Windows")
                                Text("Floor")
                                Text("Solar panel")
                            }
                        }
                        .presentationDetents([.medium])
                    }
                }
            }
            .padding(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
        }
    }
}
