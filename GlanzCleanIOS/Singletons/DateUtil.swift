//
//  DateUtil.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 11.09.2023.
//

import Foundation


class DateUtil {
    static let shared = DateUtil()
    
    private init() {}
    
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
}




