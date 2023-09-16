//
//  CustomerManager.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 20.08.2023.
//

import Foundation
import Combine
import Alamofire

class CustomerManager: ObservableObject {
    // Util
    @Published var companies: [GET.CompanyShortStats] = [] // Used in CustomerView() to displays customers
    @Published var customerWithWork: GET.CompanyWithWork? // Used in CustomerDetails() to display details about a customer and its work
    @Published var booleanMonthArr = Array(repeating: false, count: Month.allCases.count) // Used to display months in SwiftUI CustomerDetailsView
    @Published var customerWithLocations: GET.CompanyWithLocations? // Used in CustomerInfoView() to display details about a custoemr and its locations
    
    
    // Company details
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var address = ""
    @Published var locations: [POST.Company.Location] = []
    
    // User for adding locations
    @Published var currentLocationName = ""
    @Published var currentLocationAddress = ""
    
    // Used for validation
    @Published var isFirstNameValid = true
    @Published var emailIsValid = false
    @Published var isPhoneValid = true
    @Published var isFormValid = false
    var isLocationValid: Bool {
        return !self.currentLocationName.isEmpty && !self.currentLocationAddress.isEmpty
    }
    
    // Prompts for errors
    var namePrompt = "Required. Name cannot contain digits or symbols."
    var emailPrompt = "Required. Enter a valid email address."
    var phonePrompt = "Phone cannot contain letters or symbols."
    
    // Publishers
    private var cancellableSet: Set<AnyCancellable> = []
    
    var isNameValidPublisher: AnyPublisher<Bool,Never> {
        $name
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
        Publishers.CombineLatest3(
            isNameValidPublisher,
            isPhoneValidPublisher,
            isEmailValidPublisher)
            .map { firstName, phone, email in
                return firstName && phone && email && !self.locations.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        isSignupFormValidPublisher
          .receive(on: RunLoop.main)
          .assign(to: \.isFormValid, on: self)
          .store(in: &cancellableSet)
    }
    
    
    func addLocation() {
        self.locations.append(POST.Company.Location(name: self.currentLocationName, address: self.currentLocationAddress))
        self.currentLocationName = ""
        self.currentLocationAddress = ""
    }
    
    func getCustomers(completion: @escaping (_ response: RequestResponse) -> Void) {
        CustomerService.shared.getCustomers { companies, response in
            switch response.status{
            case .success:
                if let companies = companies {
                    self.companies = companies
                    completion(RequestResponse(status: .success, message: ""))
                }
                else {
                    completion(RequestResponse(status: .failure, message: "Failed to retrieve companies"))
                }
            case .failure:
                completion(response)
            }
        }
    }
    
    func getCustomerWithLocations(id: UUID, completion: @escaping (_ response: RequestResponse) -> Void) {
        CustomerService.shared.getCustomerWithLocations(id: id) { customer, response in
            switch response.status{
            case .success:
                if let companies = customer {
                    self.customerWithLocations = customer
                    completion(RequestResponse(status: .success, message: ""))
                }
                else {
                    completion(RequestResponse(status: .failure, message: "Failed to retrieve customer details!"))
                }
            case .failure:
                completion(response)
            }
        }
    }
    
    func getCustomerWithWork(id: UUID, completion: @escaping (_ response: RequestResponse) -> Void) {
        CustomerService.shared.getCustomerWithWork(id: id) { customerWithWork, response in
            switch response.status {
            case .success:
                if let customer = customerWithWork {
                    self.customerWithWork = customer
                    self.booleanMonthArr = self.generateMonthBooleanArray()
                    completion(RequestResponse(status: .success, message: ""))
                }
                else {
                    completion(RequestResponse(status: .failure, message: "Failed to retrieve customer details!"))
                }
            case .failure:
                completion(response)
            }
        }
    }
    
    func postCustomer(completion: @escaping (RequestResponse) -> Void) {
        CustomerService.shared.postCustomer(parameters: POST.Company(name: self.name, address: self.address, email: self.email, phoneNumber: self.phone, locations: self.locations)) { response in
            completion(response)
            if response.status == .success {
                self.reset()
            }
        }
    }
    
    func reset() {
        name = ""
        email = ""
        phone = ""
        address = ""
        locations = []
        
        // User for adding locations
        currentLocationName = ""
        currentLocationAddress = ""
        
        // Used for validation
        isFirstNameValid = true
        emailIsValid = false
        isPhoneValid = true
        isFormValid = false
    }
    
    func getDoubleFromDecimal(value: Decimal?) -> Double {
        if let val = value {
            return NSDecimalNumber(decimal: val).doubleValue
        }
        return 0.0
    }
    
    func getWorkWith(_ id: UUID) -> GET.CompanyWithWork.WorkItem? {
        return self.customerWithWork?.work.first(where: {$0.id == id})
    }
    
}

extension CustomerManager {
    // Define your enum for months and conform to CaseIterable
    enum Month: Int, CaseIterable {
        case Jan = 1, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
        
        // Define a custom computed property to get the month name
        var monthName: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM"
            return formatter.string(from: Calendar.current.date(from: DateComponents(year: 2023, month: self.rawValue, day: 1)) ?? Date())
        }
    }
    
    func generateMonthBooleanArray() -> [Bool] {
        // Initialize a boolean array with 12 elements (one for each month)
        var monthArray = Array(repeating: false, count: Month.allCases.count)

        // Define a DateFormatter to parse the date strings
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"

        // Iterate through the date strings and update the monthArray
        if let works = customerWithWork?.work {
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
        if let work = customerWithWork?.work {
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
