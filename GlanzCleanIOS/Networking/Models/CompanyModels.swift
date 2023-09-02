//
//  CompanyModels.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 19.08.2023.
//

import Foundation

extension GET {
    struct Company: Decodable {
        let companyId: UUID?
        let name: String?
        let address: String?
        let email: String?
        let phoneNumber: String?
        let locations: [Location]?

        struct Location: Decodable {
            let locationId: UUID?
            let name: String?
            let address: String?
        }
    }
    
    struct CompanyShortStats: Decodable {
        let companyId: UUID?
        let name:String?
        let numberOfLocations: Int?
        let totalIncome: Decimal?
        let numberOfTasks: Int?
    }
    
    struct CompanyWithWork: Decodable {
        let companyId: UUID?
        let name: String?
        let address: String?
        let phoneNumber: String?
        let email: String?
        let work: [WorkItem]
        
        struct WorkItem: Decodable, Identifiable {
            let id: UUID?
            let date: String?
            let locationName: String?
            let serviceName: String?
            let totalIncome: Decimal?
            let workStatus: String?
            let accepted: Bool?
        }
    }
    
    struct CompanyWithLocations: Decodable {
        let companyId: UUID?
        let name: String?
        let address: String?
        let phoneNumber: String?
        let email: String?
        let locations: [Location]?
        
        struct Location: Decodable {
            let locationId: UUID?
            let name: String?
            let address: String?
        }
    }
    
}


extension POST {
    struct Company: Codable {
        let name: String
        let address: String
        let email: String
        let phoneNumber: String
        let locations: [Location]

        struct Location: Codable {
            let name: String
            let address: String
        }
    }
}
