//
//  Toast.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI

struct Toast: View {
    @EnvironmentObject var toastManager: ToastManager
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    Image(systemName: toastManager.toastIcon)
                    Text(toastManager.toastMessage)

                }
                .padding()
                .background(.green)
            .cornerRadius(10)
            }
            Spacer()
        }
        .font(.custom("Urbanist-Bold", size: 16))
        .offset(x: toastManager.showSuccessToast ? 0 : 300)
        .opacity(toastManager.showSuccessToast ? 1 : 0)
        .animation(Animation.easeInOut(duration: 0.3), value: toastManager.showSuccessToast)
        
    }
}

struct Toast_Previews: PreviewProvider {
    static var previews: some View {
        Toast()
    }
}
