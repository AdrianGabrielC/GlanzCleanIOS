//
//  DateFieldComponent.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI

struct DateFieldComponent: View {
    var sfSymbolName: String
    var placeHolder: String
    var prompt: String
    @Binding var field: Date
    var isSecure:Bool = false
    var isValid: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            DatePicker(selection: $field, in: ...Date.now, displayedComponents: .date) {
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
