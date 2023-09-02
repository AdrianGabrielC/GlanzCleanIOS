//
//  LocationModels.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 19.08.2023.
//

import Foundation

extension GET {
    struct Location {
        let locationId: UUID?
        let name: String?
        let address: String?
        let companyId: UUID?
    }
}

extension POST {
    struct Location : Encodable{
        let name: String
        let address: String
        let companyId: UUID
    }
}
