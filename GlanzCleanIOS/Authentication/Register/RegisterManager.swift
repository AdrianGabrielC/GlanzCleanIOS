//
//  RegisterManager.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 14.08.2023.
//

import Foundation


class RegisterManager: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var password_confirm = ""
    @Published var firstQA = ""
    @Published var secondQA = ""
    
}
