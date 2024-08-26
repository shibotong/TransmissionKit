//
//  File.swift
//  
//
//  Created by Shibo Tong on 23/8/2024.
//

import Foundation

public struct TransmissionRequest {
    
    let method: String
    let arguments: [String: [Any]]
    let tag: Int?
    
    public var jsonBody: [String: Any] {
        var json: [String: Any] = ["method": method]
        if !arguments.isEmpty {
            json["arguments"] = arguments
        }
        if let tag {
            json["tag"] = tag
        }
        return json
    }
    
    init(method: String, arguments: [String : [Any]] = [:], tag: Int? = nil) {
        self.method = method
        self.arguments = arguments
        self.tag = tag
    }
}


