//
//  TransmissionClient.swift
//
//
//  Created by Shibo Tong on 23/8/2024.
//

import Foundation
import RegexBuilder

public class TransmissionClient {
    
    static let sessionIDHeader = "X-Transmission-Session-Id"
    static let authorizationHeader = "Authorization"
    
    public let url: URL?
    
    let authorization: String?
    var sessionID: String?
    
    public var rpcVersion: Int?
    
    public init(urlString: String, username: String? = nil, password: String? = nil) {
        let rpcString = "\(urlString)/rpc"
        url = URL(string: rpcString)
        
        if let username, let password {
            authorization = "\(username):\(password)"
        } else {
            authorization = nil
        }
    }
    
    public func request(_ request: TransmissionRequest) async throws -> TransmissionResponse {
        guard let url else {
            throw TransmissionError.noURL
        }
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "POST"
        
        let bodyData = try JSONSerialization.data(withJSONObject: request.jsonBody)
        httpRequest.httpBody = bodyData
        
        if let sessionID {
            httpRequest.setValue(sessionID, forHTTPHeaderField: Self.sessionIDHeader)
        }
        
        if let authorization,
           let authorizeData = authorization.data(using: .utf8) {
            let base64String = authorizeData.base64EncodedString()
            httpRequest.setValue("Basic \(base64String)", forHTTPHeaderField: Self.authorizationHeader)
        }
        
        let (data, response) = try await URLSession.shared.data(for: httpRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw TransmissionError.unknown
        }
        
        guard httpResponse.statusCode == 200 else {
            switch httpResponse.statusCode {
            case 401:
                throw TransmissionError.unauthorized
            case 409:
                if let sessionID = httpResponse.allHeaderFields[Self.sessionIDHeader] as? String {
                    self.sessionID = sessionID
                    return try await self.request(request)
                } else {
                    throw TransmissionError.unknown
                }
            default:
                throw TransmissionError.unknown
            }
        }
        
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw TransmissionError.notJSON
        }
        
        guard let result = json["result"] as? String,
              let arguments = json["arguments"] as? [String: Any] else {
            throw TransmissionError.notFormatted
        }
        
        return TransmissionResponse(arguments: arguments, result: result)
    }
}
