//
//  InvoiceView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI

struct InvoiceSectionHeader: View {
    var body: some View {
        HStack {
            Text("January")
            Spacer()
            Text("Total: 6,500€")
        }
    }
}

struct InvoiceView: View {
    @State var searchText = ""
    @State var date = Date()
    @State var pause = 0

    var body: some View {
        VStack(alignment: .leading) {
            Text("Invoices")
                .font(.custom("Urbanist-Bold", size: 32))
                .padding(.leading, 30)
            HStack(alignment: .bottom) {
                Image("InvoiceImg")
                    .resizable()
                    .scaledToFit()
                    .frame(height:100)
                    .padding(.horizontal)
                Spacer()
                
            }
            HStack {
                CustomSearchBar(text: $searchText)
                NavigationLink(destination: InvoiceAddView()) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .frame(width: 25, height: 25)
                        .padding(5)
                        .background(Color(red: 18/255, green: 18/255, blue: 18/255))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                        
                }
            }.padding()
            List {
                ForEach(1...2, id:\.self) { invoice in
                    HStack {
                        Text("FEBRUARY")
                        Spacer()
                        Text("TOTAL: 6,500$")
                            .font(.custom("Urbanist-Bold", size: 14))
                            .foregroundColor(.green)
                    }
                    .padding(.top, invoice != 1 ? 50 : 0)
                    .font(.footnote)
                    .foregroundColor(Color(red: 115/255, green: 115/255, blue: 118/255))
                    ForEach(1...5, id:\.self) { q in
                        NavigationLink {
                            InvoiceDetailsView()
                        }label: {
                            HStack {
                                HStack(spacing: 10) {
                                    Image("InvoiceIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:25)
                                    Text("127")
                                    
                                }.frame(width: 80, alignment: .leading)
                                Text("OLA Gebaudereingung")
                                    .frame(width: 50, alignment: .center)
                                    .font(.custom("Urbanist-Regular", size: 12))
                                Text("26.04.23")
                                    .frame(width: 50, alignment: .center)
                                    .font(.custom("Urbanist-Regular", size: 12))
                                Text("666,00€")
                                    .frame(width: 50, alignment: .trailing)
                                    .font(.custom("Urbanist-Regular", size: 12))
                                    .foregroundColor(.green)
                                    .bold()
                                Text("Due")
                                    .frame(width: 40, alignment: .center)
                                    .background(.gray)
                                    .cornerRadius(12)
                                    .foregroundColor(.black)
                                    .bold()
                                Text("Filed")
                                    .frame(width: 40, alignment: .center)
                                    .background(.green)
                                    .cornerRadius(12)
                                    .foregroundColor(.black)
                                    .bold()
                            }
                            //.font(.custom("Urbanist-Bold", size: 10))
                        }
                    }
                    .onDelete { i in

                    }

                }

            }
            .listStyle(.plain)
            .font(.caption2)
            
            Spacer()
        }

    }
}

struct InvoiceView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceView()
    }
}
