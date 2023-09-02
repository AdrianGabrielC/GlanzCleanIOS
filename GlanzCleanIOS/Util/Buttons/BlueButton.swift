//
//  BlueButton.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 27.08.2023.
//

import SwiftUI

struct BlueButton: View {
    var width: CGFloat?
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        }label: {
            Text(text)
                .font(.custom("Urbanist-Regular", size: 16))
                .foregroundColor(.black)
        }
        .frame(maxWidth: width != nil ? width : .infinity, maxHeight: 50)
        .background(.blue.gradient)
        .cornerRadius(10)
    }
}

struct BlueButton_Previews: PreviewProvider {
    static var previews: some View {
        BlueButton(text: "", action: {})
    }
}
