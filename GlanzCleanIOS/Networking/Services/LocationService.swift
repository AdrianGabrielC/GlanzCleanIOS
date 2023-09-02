//
//  LocationService.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 27.08.2023.
//

import Foundation
import Alamofire

class LocationService: ObservableObject {
    
    static let shared = LocationService()
    
    private init() {}
    
    
    func postLocation(parameters: POST.Location, completion: @escaping (_ response: RequestResponse) -> Void) {
        let url = "https://glanzclean.azurewebsites.net/api/locations"
        
           
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
                        print("Response: Location successfully added.")
                        // Handle success. 'value' contains the response data.
                        completion(RequestResponse(status: .success, message: "Location successfully added!"))
                    case .failure(let error):
                        print("Response: Failed to add location: \(error)")
                        // Handle error. 'error' contains the error information.
                        completion(RequestResponse(status: .failure, message: "Failed to add location!"))
                    }
                }
        } catch {
            print("Error encoding POST.Loation")
            completion(RequestResponse(status: .failure, message: "Failed to add location!"))
        }
    }
}
