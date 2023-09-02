//
//  ToastManager.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import Foundation
import SwiftUI

class ToastManager: ObservableObject {
    @Published var showSuccessToast = false
    @Published var showFailureToast = false
    @Published var toastMessage = "Success"
    @Published var toastIcon = "checkmark"
    @Published var toastColor = Color(.green)
    
//    static let shared = ToastManager()
//    
//    private init() {}
 
    func showToast(type: Status, message: String) {
        if type == .success {showSuccessToast = true}
        else {showFailureToast = true}
        toastMessage = message
        toastIcon = type == .success ? "checkmark" : "multiply"
        toastColor = type == .success ? .green : .red
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if type == .success {self.showSuccessToast = false}
            else {self.showFailureToast = false}
        }
    }
    
    enum Status {
        case success
        case failure
    }
}


