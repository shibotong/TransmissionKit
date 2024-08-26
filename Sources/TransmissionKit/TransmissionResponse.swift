//
//  File.swift
//  
//
//  Created by Shibo Tong on 23/8/2024.
//

import Foundation

public struct TransmissionResponse {
    
    let arguments: [String: Any]
    let result: String
    
    var isSuccess: Bool {
        return result == "success"
    }
}
