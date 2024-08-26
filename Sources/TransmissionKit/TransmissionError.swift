//
//  File.swift
//  
//
//  Created by Shibo Tong on 23/8/2024.
//

import Foundation

public enum TransmissionError: Error {
    case noURL
    case unauthorized
    case notJSON
    case notFormatted
    case unknown
//    case argumentNotExistForVer(TransmissionArguments, Int)
}
