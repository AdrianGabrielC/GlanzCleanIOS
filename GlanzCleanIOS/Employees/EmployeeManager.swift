//
//  EmployeeManager.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import Foundation
import Combine

class EmployeeManager: ObservableObject {
    @Published var employees: [GET.EmployeeSummary] = []
    @Published var employee: GET.Employee?
    @Published var employeeWithWork: GET.EmployeeWithWork?
    @Published var booleanMonthArr = Array(repeating: false, count: Month.allCases.count) // Used to display months in SwiftUI CustomerDetailsView

    
    func getEmployees(completion: @escaping (RequestResponse) -> Void) {
        EmployeeService.shared.getEmployees { employees, response in
            switch response.status {
            case .success:
                if let employees = employees {
                    self.employees = employees
                    completion(RequestResponse(status: .success, message: ""))
                }
                else {
                    completion(RequestResponse(status: .failure, message: "Failed to retrieve employees"))
                }
            case .failure:
                completion(response)
            }
        }
    }
    
    func getEmployeeDetails(id:UUID, completion: @escaping (RequestResponse) -> Void) {
        EmployeeService.shared.getEmployeeDetails(id: id) { employee, response in
            switch response.status {
            case .success:
                if let employee = employee {
                    self.employee = employee
                    completion(RequestResponse(status: .success, message: ""))
                }
                else {
                    completion(RequestResponse(status: .failure, message: "Failed to retrieve employee details!"))
                }
            case .failure:
                completion(response)
            }
        }
    }
    
    func getDoubleFromDecimal(value: Decimal?) -> Double {
        if let val = value {
            return NSDecimalNumber(decimal: val).doubleValue
        }
        return 0.0
    }
}

class EmployeeUpdateFormManager: ObservableObject {
    @Published var id: String = ""
    
    @Published var firstName: String = ""
    @Published var isFirstNameValid = true
    
    @Published var lastName: String = ""
    @Published var isLastNameValid = true
    
    @Published var email: String = ""
    @Published var emailIsValid = false
    
    @Published var phone: String = ""
    @Published var isPhoneValid = true
    
    
    
    @Published var address = ""
    
    @Published var status = ""
    
    @Published var isFormValid = false
    
    
    var firstNamePrompt = "Required. Name cannot contain digits or symbols."
    var lastNamePrompt = "Required. Name cannot contain digits or symbols."
    var emailPrompt = "Required. Enter a valid email address."
    var phonePrompt = "Phone cannot contain letters or symbols."
    
    // Publishers
    private var cancellableSet: Set<AnyCancellable> = []
    
    var isFirstNameValidPublisher: AnyPublisher<Bool,Never> {
        $firstName
            .map { val in
                if val.isEmpty == false && val.lettersOnly {
                    self.isFirstNameValid = true
                    return true
                }
                else {
                    self.isFirstNameValid = false
                    return false
                }
                
            }
            .eraseToAnyPublisher()
    }
    var isLastNameValidPublisher: AnyPublisher<Bool,Never> {
        $lastName
            .map { val in
                if val.isEmpty == false && val.lettersOnly {
                    self.isLastNameValid = true
                    return true
                }
                else {
                    self.isLastNameValid = false
                    return false
                }
            }
            .eraseToAnyPublisher()
    }

    var isPhoneValidPublisher: AnyPublisher<Bool,Never> {
        $phone
            .map { val in
                if self.phone != "" && !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: val)) {
                    self.isPhoneValid = false
                    return false
                }
                else {
                    self.isPhoneValid = true
                    return true
                }
            }
            .eraseToAnyPublisher()
    }
    var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { email in
                let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
                self.emailIsValid = emailPredicate.evaluate(with: email)
                return emailPredicate.evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }

    var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(
            isFirstNameValidPublisher,
            isLastNameValidPublisher,
            isPhoneValidPublisher,
            isEmailValidPublisher)
            .map { firstName, lastName, phone, email in
                return firstName && lastName && phone && email
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        isSignupFormValidPublisher
          .receive(on: RunLoop.main)
          .assign(to: \.isFormValid, on: self)
          .store(in: &cancellableSet)
    }
    
    
    func getNewObject() -> EmployeeModel {
        let newEmployee = EmployeeModel(id: self.id == "" ? UUID().uuidString : self.id,
                                         firstName: self.firstName,
                                         lastName: self.lastName,
                                         address: self.address,
                                         phone: self.phone,
                                         email: self.email,
                                         status: self.status == "" ? "Active" : self.status)
        return newEmployee
    }
    
    func setValues(_ employee: EmployeeModel) {
        id = employee.id
        firstName = employee.firstName
        lastName = employee.lastName
        address = employee.address
        email = employee.email
        phone = employee.phone
        status = employee.status
    }
    

}

extension String {
    /// Allows only `a-zA-Z0-9`
    public var lettersOnly: Bool {
        guard !isEmpty else {
            return false
        }
        let allowed = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let characterSet = CharacterSet(charactersIn: allowed)
        guard rangeOfCharacter(from: characterSet.inverted) == nil else {
            return false
        }
        return true
    }
}


extension EmployeeManager {
    // Define your enum for months and conform to CaseIterable
    enum Month: Int, CaseIterable {
        case Jan = 1, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
        
        // Define a custom computed property to get the month name
        var monthName: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM"
            return formatter.string(from: DateComponents(month: self.rawValue).date ?? Date())
        }
    }
    
    func generateMonthBooleanArray() -> [Bool] {
        // Initialize a boolean array with 12 elements (one for each month)
        var monthArray = Array(repeating: false, count: Month.allCases.count)

        // Define a DateFormatter to parse the date strings
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"

        // Iterate through the date strings and update the monthArray
        if let works = employeeWithWork?.work {
            for work in works {
                if let date = dateFormatter.date(from: work.date ?? "") {
                    // Extract the month from the date
                    let calendar = Calendar.current
                    let month = calendar.component(.month, from: date)

                    // Update the corresponding element in the monthArray
                    if let index = Month(rawValue: month)?.rawValue {
                        monthArray[index - 1] = true
                    }
                }
            }
        }
        return monthArray
    }
    
    func getMonthEnumFromDateString(_ dateString: String) -> Month? {
           // Define a DateFormatter to parse the date strings
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"

           if let date = dateFormatter.date(from: dateString) {
               // Extract the month from the date
               let calendar = Calendar.current
               let month = calendar.component(.month, from: date)

               // Return the corresponding Month enum case
               return Month(rawValue: month)
           }

           // If the date string couldn't be parsed, return nil
           return nil
       }
    
    func getMonthIndexFromDateString(_ dateString: String) -> Int? {
           // Define a DateFormatter to parse the date strings
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"

           if let date = dateFormatter.date(from: dateString) {
               // Extract the month from the date
               let calendar = Calendar.current
               let month = calendar.component(.month, from: date)

               // Return the month index (0 to 11)
               return month - 1
           }

           // If the date string couldn't be parsed, return nil
           return nil
       }
    
    func getStringDatesForMonthIndex(_ index: Int) -> [GET.CompanyWithWork] {
        // Define a DateFormatter to parse the date strings
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
          
          // Use the filter function to select string dates with the specified month index
        if let work = employeeWithWork?.work {
            let filteredDates = work.filter { work in
                if let date = dateFormatter.date(from: work.date ?? "") {
                    let calendar = Calendar.current
                    let month = calendar.component(.month, from: date)
                    return month - 1 == index
                }
                return false
            }
        }
        return []
    }
    
    func getPrettyDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM dd, yyyy"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
}
