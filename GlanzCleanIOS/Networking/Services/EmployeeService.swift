//
//  EmployeeService.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 30.08.2023.
//

import Foundation
import Alamofire

class EmployeeService: ObservableObject {
    
    static let shared = EmployeeService()
    
    private init() {}
    
    func getEmployees(completion: @escaping (_ employees: [GET.EmployeeSummary]?, _ response: RequestResponse) -> Void) {
        let url = "https://glanzclean.azurewebsites.net/api/employees"
        
        AF.request(url, method: .get)
               .validate()
               .responseDecodable(of: [GET.EmployeeSummary].self) { response in
                   print("Url: \(url)")
                   print("Method: GET")
                   switch response.result {
                   case .success(let employees):
                       print("Result: \(employees)")
                       completion(employees, RequestResponse(status: .success, message: ""))
                   case .failure(let error):
                       // If the request fails, pass the error to the completion handler.
                       print("Result: Error \(error)")
                       completion(nil, RequestResponse(status: .failure, message:"Failed to retrieve employees!"))
                   }
               }
    }
    
    func getEmployeeDetails(id:UUID, completion: @escaping (_ employees: GET.Employee?, _ response: RequestResponse) -> Void) {
        let url = "https://glanzclean.azurewebsites.net/api/employees/\(id)"
        
        AF.request(url, method: .get)
               .validate()
               .responseDecodable(of: GET.Employee.self) { response in
                   print("Url: \(url)")
                   print("Method: GET")
                   switch response.result {
                   case .success(let employee):
                       print("Result: \(employee)")
                       completion(employee, RequestResponse(status: .success, message: ""))
                   case .failure(let error):
                       // If the request fails, pass the error to the completion handler.
                       print("Result: Error \(error)")
                       completion(nil, RequestResponse(status: .failure, message:"Failed to retrieve employee details!"))
                   }
               }
    }
}
