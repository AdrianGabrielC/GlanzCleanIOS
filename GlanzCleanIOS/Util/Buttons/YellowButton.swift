//
//  YellowButton.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 14.08.2023.
//

import SwiftUI

struct YellowButton: View {
    var width: CGFloat?
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        }label: {
            Text(text)
                .font(.custom("Urbanist-Bold", size: 18))
                .foregroundColor(.white)
        }
        .frame(maxWidth: width != nil ? width : .infinity)
        .frame(height: 40)
        .background(Color("MainYellow").gradient)
        .cornerRadius(10)
    }
}

struct YellowButton_Previews: PreviewProvider {
    static var previews: some View {
        YellowButton(text: "Submit", action: {})
    }
}
