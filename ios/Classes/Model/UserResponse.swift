//
//  UserResponse.swift
//  integration_test
//
//  Created by Najam Us Saqib on 26/02/2024.
//

import Foundation

// MARK: - User Mode -

struct User {
    let displayName: String?
    let avatarId: String?
    let avatarUrl: String?
    let externalId: String?
    let tokenId: String?
    let profileLink: String?
    
    func toMap() -> [String : Any] {
        return [
            "displayName" : displayName as Any,
            "avatarId" : avatarId as Any,
            "avatarUrl" : avatarUrl as Any,
            "externalId" : externalId as Any,
            "tokenId" : tokenId as Any,
            "profileLink" : profileLink as Any
        ]
    }
}

// MARK: - User Response -

struct UserResponse: SnapchatResponse {
    var code: Int = 200
    var message: String = ""
    var user: User?
    
    func toMap() -> [String : Any?] {
        return [
            "code" : code,
            "message" : message,
            "user" : user?.toMap() as Any
        ]
    }
}
