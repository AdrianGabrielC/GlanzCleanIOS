//
//  NewInvoiceDetailsView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 11.09.2023.
//

import SwiftUI

struct NewInvoiceDetailsView: View {
    @EnvironmentObject var toastManager: ToastManager
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    VStack(spacing: 5) {
                        Text("Glanz Clean")
                        Text("Gebaudereinigung")
                    }.bold()
                }.padding(.trailing, 50).padding(.bottom)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("SC Glanz Clean SRL").bold()
                    Text("Sorin Postelnicescu").foregroundColor(.gray)
                    Text("Rotarest Dn Str. 132 B * 117045 * Bascov Jud. Arges").foregroundColor(.gray)
                        .padding(.bottom)
                }.font(.footnote)
                
                HStack {
                    Spacer()
                    VStack(alignment:.leading, spacing: 5) {
                        HStack {
                            Text("Rechnungsnummer:").bold().frame(width:150, alignment: .leading)
                            Text("73").foregroundColor(.gray)
                        }
                        HStack {
                            Text("Rechnungsdatum:").bold().frame(width:150, alignment: .leading)
                            Text("21.08.2022").foregroundColor(.gray)
                        }
                        HStack {
                            Text("Zahlungsbedingungen:").bold().frame(width:150, alignment: .leading)
                            Text("30 tage").foregroundColor(.gray)
                        }
                        HStack {
                            Text("Faliigkeitsdatum:").bold().frame(width:150, alignment: .leading)
                            Text("20.09.2022").foregroundColor(.gray)
                        }
                    }.padding(.bottom).font(.footnote)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("OLA Gebaudereinigung")
                    Text("Lumnije Zeneli")
                    Text("Unterweller 46")
                    Text("77770 Durbach")
                }.bold().padding(.bottom).font(.footnote)
                

                
                Text("Rechnung").bold()
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(alignment:.leading, spacing: 5) {
                        HStack(alignment:.top) {
                            Text("Beschreibung").frame(width:80)
                            Text("Datum").frame(width:40)
                            Text("Menge").frame(width:40)
                            Text("Einheit").frame(width:40)
                            Text("Einzelpreis").frame(width:40)
                            Text("USt.%").frame(width:40)
                            Text("Betrag").frame(width:60)
                        }.padding(3).font(.system(size: 11)).background(Color(red: 70/255, green: 70/255, blue: 70/255)).bold()
                        
                        HStack(alignment:.top) {
                            Text("Glasreiningung CallCenter Offenburg").frame(width:80)
                            Text("16.08.2022").frame(width:40)
                            Text("8,50").frame(width:40)
                            Text("h").frame(width:40)
                            Text("18$").frame(width:40)
                            Text("0%").frame(width:40)
                            Text("1533,00$").frame(width:60)
                        }.font(.system(size: 11)).bold()

                        HStack(alignment:.top) {
                            Text("Glasreiningung CallCenter Offenburg").frame(width:80)
                            Text("16.08.2022").frame(width:40)
                            Text("8,50").frame(width:40)
                            Text("h").frame(width:40)
                            Text("18$").frame(width:40)
                            Text("0%").frame(width:40)
                            Text("1533,00$").frame(width:60)
                        }.font(.system(size: 11)).bold()
                        HStack(alignment:.top) {
                            Text("Grundreiningung Kindergarten Renchen und Privat Haus").frame(width:80)
                            Text("16.08.2022").frame(width:40)
                            Text("8,50").frame(width:40)
                            Text("h").frame(width:40)
                            Text("18$").frame(width:40)
                            Text("0%").frame(width:40)
                            Text("1533,00$").frame(width:60)
                        }.font(.system(size: 11)).bold()
      
                    }
                }
                Rectangle().fill(Color(red: 70/255, green: 70/255, blue: 70/255)).frame(height: 2).padding(.bottom)
                

                
                HStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Nettobetrag")
                            Spacer()
                            Text("1.314,00$")
                        }.font(.system(size: 14))
                        
                        HStack {
                            Text("USt. 0,00%")
                            Spacer()
                            Text("0,00$")
                        }.font(.system(size: 14))
                        Rectangle().fill(Color(red: 70/255, green: 70/255, blue: 70/255)).frame(height: 2)
                        HStack {
                            Text("Gesamtsumme")
                            Spacer()
                            Text("1.314,00$")
                        }.font(.system(size: 16))
                    }.frame(maxWidth: 200)
                }.bold().padding(.bottom, 50)
                
                VStack(alignment:.center, spacing: 5) {
                    Rectangle().fill(Color(red: 70/255, green: 70/255, blue: 70/255)).frame(height: 2).padding(.bottom)
                    Text("**Adresse** Rotaresti Dn Str. 132B * 117045 * Bascov Jud. Arges")
                    HStack {
                        Text("**Steuernummer** 44869103")
                        Text("**Mobil** 0049151124405572")
                    }
                    HStack {
                        Text("**USt-IdNr.** ROONRC.J3/2148/2021")
                        Text("**Bank** Ing Bank")
                    }
                    HStack {
                        Text("**SWIFT/BIC** INGBROBU")
                        Text("**IBAN** RO65INGB0000999911794359")
                    }
                    
                }.font(.system(size: 11))

                YellowButton(text: "Add invoice") {
                    presentationMode.wrappedValue.dismiss()
                    toastManager.showToast(type: .success, message: "Invoice successfully added!")
//                    isLoading = true
//                    formManager.postWork { response in
//                        isLoading = false
//                        switch response.status {
//                        case .success:
//                            dismiss()
//                            toastManager.showToast(type: .success, message: "Work successfully added!")
//                        case .failure:
//                            toastManager.showToast(type: .failure, message: "Failed to add work!")
//                        }
//                    }
                }.padding(.top, 40)
                    .padding(.horizontal).padding(.bottom)
            }.padding(5)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button {
            presentationMode.wrappedValue.dismiss()
        }label: {
            HStack {
                Image(systemName: "arrow.left.circle.fill").font(.title)
                Text("Invoice summary").font(.custom("Urbanist-Bold", size: 24))
            }.foregroundColor(Color("MainYellow"))
        })
    }
}

struct NewInvoiceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NewInvoiceDetailsView()
    }
}
