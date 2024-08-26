//
//  File.swift
//  
//
//  Created by Shibo Tong on 23/8/2024.
//

import Foundation

public struct TransmissionResponse {
    
    public let arguments: [String: Any]
    public let result: String
    
    public var isSuccess: Bool {
        return result == "success"
    }
}
