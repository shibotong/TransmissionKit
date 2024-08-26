//
//  TransmissionClientTests.swift
//  
//
//  Created by Shibo Tong on 23/8/2024.
//

import XCTest
@testable import TransmissionKit

final class TransmissionClientTests: XCTestCase {
    
    var client: TransmissionClient!

    override func setUp() {
        client = TransmissionClient(urlString: "http://192.168.1.250:9091/transmission", username: "admin", password: "123456")
    }

    func testClientConnection() async throws {
        let result = try await client.connect()
        XCTAssertEqual(result, true)
    }
}
