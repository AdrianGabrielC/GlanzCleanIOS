//
//  CalendarManager.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import Foundation

class CalendarManager: ObservableObject {
    
    // MARK: - CALENDAR LOGIC
    func getCurrentMonth() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: currentDate)
    }
    
    func getPrettyDateString(_ inputDateStr: String) -> String? {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd MMM yyyy"
        
        if let date = dateFormatterInput.date(from: inputDateStr) {
            return dateFormatterOutput.string(from: date)
        }
        
        return nil // Return nil if the input string is not in the expected format
    }
    
    func getMonthNameString(_ inputDateStr: String) -> String? {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "MMMM"
        
        if let date = dateFormatterInput.date(from: inputDateStr) {
            return dateFormatterOutput.string(from: date)
        }
        
        return nil // Return nil if the input string is not in the expected format
    }
    
    func getDayOfMonthInt(from dateString: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let dayOfMonth = calendar.component(.day, from: date)
            return dayOfMonth
        }
        
        return nil // Return nil for invalid date strings
    }
    
    func getMonthIntFromDateString(_ dateString: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"

        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let month = calendar.component(.month, from: date)
            return month
        } else {
            return nil // Parsing failed
        }
    }
    
    // Used in Day view in calendar to compute the height of each rectangle
    func convertDateStringToDouble(_ dateString: String) -> Double? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let hour = Double(calendar.component(.hour, from: date))
            let minute = Double(calendar.component(.minute, from: date))
            let doubleValue = hour + (minute / 60.0)
            return doubleValue
        } else {
            // Invalid date string
            return nil
        }
    }
    
    func getDaysInMonth(_ month: Int) -> Int? {
        let calendar = Calendar.current
        
        // Ensure the month is within a valid range
        guard (1...12).contains(month) else {
            return nil
        }
        
        // Get the current year
        let currentYear = calendar.component(.year, from: Date())
        
        // Create a DateComponents object for the given year and month
        var dateComponents = DateComponents()
        dateComponents.year = currentYear
        dateComponents.month = month
        
        // Calculate the last day of the specified month
        if let date = calendar.date(from: dateComponents),
           let range = calendar.range(of: .day, in: .month, for: date) {
            return range.count
        }
        
        return nil
    }
    
    func getAbbreviatedDayOfWeek(year: Int, month: Int, day: Int) -> String? {
        let calendar = Calendar.current
        
        // Ensure the month is within a valid range
        guard (1...12).contains(month) else {
            return nil
        }
        
        // Ensure the day is within a valid range for the given month
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        guard let date = calendar.date(from: dateComponents) else {
            return nil
        }
        
        // Get the abbreviated name of the day of the week
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        
        return dateFormatter.string(from: date)
    }

    func getDoubleFromDecimal(value: Decimal?) -> Double {
        if let val = value {
            return NSDecimalNumber(decimal: val).doubleValue
        }
        return 0.0
    }
    
    // MARK: - GET WORK
    @Published var work: [GET.WorkSummary] = []
    
    func getWork(year:Int, month:Int?, day:Int?, completion: @escaping (RequestResponse) -> Void) {
        WorkService.shared.getWork(year: year, month: month, day: day) { work, response in
            if let work = work {
                self.work = work
            }
            completion(response)
        }
    }
    
    
    // MARK: - POST WORK
    // TIME
    @Published var date: Date = Date.now
    @Published var beginHour: Date = Date.now
    @Published var workBreak: Int = 0
    @Published var hoursWorked: Int = 0
    
    // INCOME
    @Published var pricePerHour: Double = 0 {
        didSet {
            total = pricePerHour * Double(hoursWorked)
        }
    }
    @Published var isPricePerHourValid = true
    @Published var total: Double = 0
    @Published var isTotalValid = false
    var pricePerHourPrompt = "Income cannot be negative!"
    var totalPrompt = "Income cannot be negative!"
    var workBreakPrompt = "Work break cannot be negative!"
    
    @Published var selectedCustomer: GET.CompanyShortStats?
    @Published var selectedLocation: GET.CompanyWithLocations.Location?
    @Published var selectedService: GET.Service?
    @Published var selectedEmployees: [GET.Employee] = []
    


    func postWork(completion: @escaping (RequestResponse) -> Void) {
        let employeeIds = selectedEmployees.map { employee in
            employee.id ?? UUID()
        }
        
        let work = POST.Work(date: convertDateToString(date: date),
                             startDateTimeUtc: convertDateToString(date: beginHour),
                             locationId: selectedLocation?.locationId ?? UUID(),
                             serviceId: selectedService?.serviceId ?? UUID(),
                             hoursWorked: Decimal(hoursWorked),
                             workBreak: Decimal(workBreak),
                             pricePerHour: Decimal(pricePerHour),
                             accepted: true,
                             workStatus: "Done",
                             employeeIDs: employeeIds)
        WorkService.shared.postWork(parameters: work) { response in
            if response.status == .success {
                self.reset()
            }
            completion(response)
        }
        
    }
    
    func reset() {
        date = Date.now
        beginHour = Date.now
        workBreak = 0
        hoursWorked = 0
        pricePerHour = 0
        isPricePerHourValid = false
        total = 0
        isTotalValid = false
        selectedCustomer = nil
        selectedLocation = nil
        selectedService = nil
        selectedEmployees = []
    }
    
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dateString = dateFormatter.string(from: date)

        return dateString
    }
}


