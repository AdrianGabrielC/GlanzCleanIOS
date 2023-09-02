//
//  WorkService.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 27.08.2023.
//

import Foundation
import Alamofire

class WorkService: ObservableObject {
    
    static let shared = WorkService()
    
    private init() {}
    
    func getWork(year:Int, month: Int?, day: Int?, completion: @escaping (_ work: [GET.WorkSummary]?, _ response: RequestResponse) -> Void) {
        let url = "https://glanzclean.azurewebsites.net/api/works"
        
        var params:[String:String] = [
            "Year": String(year),
        ]
        if let month = month {
            params["Month"] = String(month)
        }
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: ["Content-Type": "application/json", "Accept":"application/json"])
               .validate()
               .responseDecodable(of: [GET.WorkSummary].self) { response in
                   print("Url: \(url)")
                   print("Method: GET")
                   switch response.result {
                   case .success(let work):
                       print("Result: \(work)")
                       completion(work, RequestResponse(status: .success, message: ""))
                   case .failure(let error):
                       print("Error: \(error)")
                       completion(nil, RequestResponse(status: .failure, message:"Failed to retrieve work!"))
                   }
               }
    }
    
    func getWorkDetails(id: UUID, completion: @escaping (_ workDetails: GET.WorkDetails?, _ response: RequestResponse) -> Void) {
        let url = "https://glanzclean.azurewebsites.net/api/works/\(id)"
        
        AF.request(url, method: .get)
               .validate()
               .responseDecodable(of: GET.WorkDetails.self) { response in
                   print("Url: \(url)")
                   print("Method: GET")
                   switch response.result {
                   case .success(let work):
                       print("Result: \(work)")
                       completion(work, RequestResponse(status: .success, message: ""))
                   case .failure(let error):
                       print("Error: \(error)")
                       completion(nil, RequestResponse(status: .failure, message:"Failed to retrieve work details!"))
                   }
               }
    }
    
    func postWork(parameters: POST.Work, completion: @escaping (_ response: RequestResponse) -> Void) {
        let url = "https://glanzclean.azurewebsites.net/api/works"
        
           
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(parameters)
            
            AF.upload(jsonData, to: url, method: .post, headers: ["Content-Type": "application/json"])
                .validate()
                .responseJSON { response in
                    print("Url: \(url)")
                    print("Method: POST")
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        print("Parameters: \(jsonString)")
                    }
                    switch response.result {
                    case .success(let value):
                        print("Response: Work successfully added.")
                        // Handle success. 'value' contains the response data.
                        completion(RequestResponse(status: .success, message: "Work successfully added!"))
                    case .failure(let error):
                        print("Response: Failed to add work: \(error)")
                        // Handle error. 'error' contains the error information.
                        completion(RequestResponse(status: .failure, message: "Failed to add work!"))
                    }
                }
        } catch {
            print("Error encoding POST.Work")
            completion(RequestResponse(status: .failure, message: "Failed to add work!"))
        }
    }
}
