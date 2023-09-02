//
//  ServicesService.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 20.08.2023.
//

import Foundation
import Alamofire


class ServicesService: ObservableObject {
    
    static let shared = ServicesService()
    
    private init() {}
    
    func getServices(completion: @escaping (_ services: [GET.Service]?, _ response: RequestResponse) -> Void) {
        let url = "https://glanzclean.azurewebsites.net/api/services"
        
        AF.request(url, method: .get)
               .validate()
               .responseDecodable(of: [GET.Service].self) { response in
                   print("Url: \(url)")
                   print("Method: GET")
                   switch response.result {
                   case .success(let services):
                       print("Result: \(services)")
                       completion(services, RequestResponse(status: .success, message: ""))
                   case .failure(let error):
                       print("Result: Error \(error)")
                       completion(nil, RequestResponse(status: .failure, message:"Failed to retrieve services!"))
                   }
               }
    }
    
    func postService(parameters: POST.Service, completion: @escaping (RequestResponse) -> Void) {
        // Define the URL you want to send the POST request to.
        let url = "https://glanzclean.azurewebsites.net/api/services"
           
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
