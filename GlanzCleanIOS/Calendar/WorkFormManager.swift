//
//  WorkFormManager.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 27.08.2023.
//

import Foundation
import Alamofire

class WorkFormManager: ObservableObject {
    @Published var name: String = ""
    @Published var locationName = ""
    @Published var locationAddress = ""
    @Published var date: String = ""
    @Published var startTime: String = ""
    @Published var serviceName: String = ""
    @Published var hoursWorked: Double = 0.0
    @Published var workBreak: Int = 0
    @Published var pricePerHour: Double = 0.0
  
}
