//
//  InvoiceModels.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 19.08.2023.
//

import Foundation

extension GET {
    
    struct Invoice {
        let invoiceId: UUID?
        let invoiceNumber: String?
        let work: Work?

        struct Work {
            let id: UUID?
            let date: Date?
            let startDateTimeUtc: Date?
            let workStatus: String?
            let accepted: String?
            let location: Location?
            let service: Service?
            let hoursWorked: Decimal?
            let workBreak: Decimal?
            let pricePerHour: Decimal?
            let employeeWork: [EmployeeWork]?

        struct Location {
            let locationId: UUID?
            let name: String?
            let address: String?
        }

        struct Service {
            let serviceId: UUID?
            let name: String?
            let description: String?
        }

        struct EmployeeWork{
               let id: UUID?
                let employeeName: String?
            }
        }
    }
    
    struct InvoiceSummary {
        let invoiceId: UUID?
        let invoiceNumber: String?
        let work: Work?

        struct Work {
            let id: UUID?
            let date: Date?
            let workStatus: String?
            let accepted: Bool?
            let totalIncome: Decimal?
            let serviceName: String?
            let companyName: String?
        }
    }
}

extension POST {
    struct InvoicePostModel {
        let invoiceNumber: String
        let status: String
        let workId: UUID
    }
}
