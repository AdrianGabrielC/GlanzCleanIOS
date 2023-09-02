//
//  BlackButton.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 14.08.2023.
//

import SwiftUI

struct BlackButton: View {
    var width: CGFloat?
    var text: String
    
    var body: some View {
        Button {
            
        }label: {
            Text(text)
                .font(.custom("Urbanist-Black", size: 18))
                .foregroundColor(.white)
        }
        .frame(maxWidth: width != nil ? width : .infinity, maxHeight: 50)
        .background(.black)
        .cornerRadius(28)
    }
}

struct BlackButton_Previews: PreviewProvider {
    static var previews: some View {
        BlackButton(text: "Submit")
    }
}
