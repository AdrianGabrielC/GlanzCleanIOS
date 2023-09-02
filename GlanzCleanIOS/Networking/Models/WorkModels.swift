//
//  WorkModels.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 19.08.2023.
//

import Foundation

extension GET {
    struct WorkDetails: Decodable, Identifiable{
        let id: UUID?
        let date: String?
        let startDateTimeUtc: String?
        let workStatus: String?
        let accepted: String?
        let location: Location?
        let service: Service?
        let hoursWorked: Decimal?
        let workBreak: Int?
        let pricePerHour: Decimal?
        let employeeWork: [EmployeeWork]?

        struct Location: Decodable {
            let locationId: UUID?
            let name: String?
            let address: String?
        }

        struct Service: Decodable {
            let serviceId: UUID?
            let name: String?
            let description: String?
        }

        struct EmployeeWork: Decodable, Identifiable {
               let id: UUID?
                let employeeName: String?
            }
    }
    
    struct WorkSummary: Decodable, Identifiable {
        let id: UUID?
        let date: String?
        let workStatus: String?
        let accepted: Bool?
        let totalIncome: Decimal?
        let serviceName: String?
        let companyName: String?
    }
}

extension POST {
    struct Work:Encodable {
        let date: String
        let startDateTimeUtc: String
        let locationId: UUID
        let serviceId: UUID
        let hoursWorked: Decimal
        let workBreak: Decimal
        let pricePerHour: Decimal
        let accepted: Bool
        let workStatus: String
        let employeeIDs: [UUID]
    }
}
