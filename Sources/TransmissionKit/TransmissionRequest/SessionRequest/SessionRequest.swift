//
//  File.swift
//  
//
//  Created by Shibo Tong on 26/8/2024.
//

import Foundation

enum SessionMethod: String {
    case get, set
}

extension TransmissionRequest {
    static func session(method: SessionMethod, arguments: [String: [String]], tag: Int? = nil) -> TransmissionRequest {
        TransmissionRequest(method: "session-\(method.rawValue)", arguments: arguments, tag: tag)
    }
}

