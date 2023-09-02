//
//  RequestResponse.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 20.08.2023.
//

import Foundation



struct RequestResponse {
    let status: Status
    let message: String
    
    enum Status {
        case success
        case failure
    }
}
