//
//  EmployeeModels.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 19.08.2023.
//

import Foundation

extension GET {
    struct Employee: Decodable {
        let id: UUID?
        let firstName: String?
        let lastName: String?
        let status: String?
        let email: String?
        let phoneNumber: String?
    }

    struct EmployeeSummary: Decodable, Identifiable{
        let id: UUID?
        let firstName: String?
        let lastName: String?
        let status: String?
    }
    
    struct EmployeeWithWork: Decodable, Identifiable {
        let id: UUID?
        let firstName: String?
        let lastName: String?
        let status: String?
        let work: [WorkItem]?
        
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
}

extension POST {
    struct Employee: Encodable {
        let firstName: String
        let lastName: String
        let email: String
        let status: String
        let phoneNumber: String
    }
}
