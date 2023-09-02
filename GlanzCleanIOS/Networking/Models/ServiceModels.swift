//
//  ServiceModels.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 19.08.2023.
//

import Foundation

extension GET {
    struct Service: Decodable {
        let serviceId: UUID?
        let name: String?
        let description: String?
    }
}


extension POST {
    struct Service: Encodable {
        let name: String
        let description: String
    }
}
