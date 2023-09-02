//
//  CustomerService.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 20.08.2023.
//

import Foundation
import Alamofire

class CustomerService: ObservableObject {
    
    static let shared = CustomerService()
    
    private init() {}
    
    func getCustomers(completion: @escaping (_ companies: [GET.CompanyShortStats]?, _ response: RequestResponse) -> Void) {
        let url = "https://glanzclean.azurewebsites.net/api/companies"
        
        AF.request(url, method: .get)
               .validate()
               .responseDecodable(of: [GET.CompanyShortStats].self) { response in
                   print("Url: \(url)")
                   print("Method: GET")
                   switch response.result {
                   case .success(let companies):
                       print("Result: \(companies)")
                       completion(companies, RequestResponse(status: .success, message: ""))
                   case .failure(let error):
                       // If the request fails, pass the error to the completion handler.
                       print("Result: Error \(error)")
                       completion(nil, RequestResponse(status: .failure, message:"Failed to retrieve companies!"))
                   }
               }
    }
    
    func getCustomerWithLocations(id: UUID, completion: @escaping (_ customerWithLocation: GET.CompanyWithLocations?, _ response: RequestResponse) -> Void) {
        let url = "https://glanzclean.azurewebsites.net/api/companywithlocation/\(id)"
        
        AF.request(url, method: .get)
               .validate()
               .responseDecodable(of: GET.CompanyWithLocations.self) { response in
                   print("Url: \(url)")
                   print("Method: GET")
                   switch response.result {
                   case .success(let customer):
                       print("Result: \(customer)")
                       completion(customer, RequestResponse(status: .success, message: ""))
                   case .failure(let error):
                       print("Error: \(error)")
                       completion(nil, RequestResponse(status: .failure, message:"Failed to retrieve company details!"))
                   }
               }
    }
    
    func getCustomerWithWork(id: UUID, completion: @escaping (_ customerWithWork: GET.CompanyWithWork?, _ response: RequestResponse) -> Void) {
        let url = "https://glanzclean.azurewebsites.net/api/companywithwork/\(id)"
        
        AF.request(url, method: .get)
               .validate()
               .responseDecodable(of: GET.CompanyWithWork.self) { response in
                   print("Url: \(url)")
                   print("Method: GET")
                   switch response.result {
                   case .success(let customer):
                       print("Result: \(customer)")
                       completion(customer, RequestResponse(status: .success, message: ""))
                   case .failure(let error):
                       print("Error: \(error)")
                       completion(nil, RequestResponse(status: .failure, message:"Failed to retrieve company details!"))
                   }
               }
    }
    
    func postCustomer(parameters: POST.Company, completion: @escaping (_ response: RequestResponse) -> Void) {
        // Define the URL you want to send the POST request to.
        let url = "https://glanzclean.azurewebsites.net/api/companies"
        
           
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(parameters)
            
            AF.upload(jsonData, to: url, method: .post, headers: ["Content-Type": "application/json"])
                .validate()
                .responseJSON { response in
                    print("Url: \(url)")
                    print("Method: POST")
                    print("Parameters: \(jsonData)")
                    switch response.result {
                    case .success(let value):
                        print("Response: Company successfully added.")
                        // Handle success. 'value' contains the response data.
                        completion(RequestResponse(status: .success, message: "Company successfully added!"))
                    case .failure(let error):
                        print("Response: Failed to add company: \(error)")
                        // Handle error. 'error' contains the error information.
                        completion(RequestResponse(status: .failure, message: "Failed to add company!"))
                    }
                }
        } catch {
            print("Error encoding POST.Company")
            completion(RequestResponse(status: .failure, message: "Failed to add company!"))
        }
    }
}
