//
//  EmployeeWorkModels.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 19.08.2023.
//

import Foundation


extension GET {
    struct EmployeeWorkWithEmployeeName{
        let id: UUID?
        let employeeName: String?
    }
}

extension POST {
    struct EmployeeWork {
        let employeeId: UUID
        let workId: UUID
    }

}
