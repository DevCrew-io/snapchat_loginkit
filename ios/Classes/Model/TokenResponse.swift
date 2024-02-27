//
//  TokenResponse.swift
//  integration_test
//
//  Created by Najam Us Saqib on 26/02/2024.
//

import Foundation

// MARK: - Token Response -

struct TokenResponse: SnapchatResponse {
    var code: Int = 200
    var message: String = ""
    var token: String?
    
    func toMap() -> [String : Any?] {
        return [
            "code" : code,
            "message" : message,
            "token" : token
        ]
    }
}
