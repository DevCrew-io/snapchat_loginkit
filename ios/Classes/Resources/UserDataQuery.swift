//
//  UserDataQuery.swift
//  snapchat_loginkit
//
//  Created by Najam Us Saqib on 23/02/2024.
//

import Foundation
import SCSDKLoginKit

// MARK: - UserFetchDataQuery -

class UserFetchDataQuery {
    
    // MARK: - Properties -
    
    let isWithDisplayName: Bool
    let isWithExternalId: Bool
    let isWithIdToken: Bool
    let isWithProfileLink: Bool
    let isWithBitmojiAvatarId: Bool
    let isWithBitmojiAvatarUrl: Bool
    
    init(fromMap map: [String : Any]) {
        isWithDisplayName = map["isWithDisplayName"] as? Bool ?? false
        isWithExternalId = map["isWithExternalId"] as? Bool ?? false
        isWithIdToken = map["isWithIdToken"] as? Bool ?? false
        isWithProfileLink = map["isWithProfileLink"] as? Bool ?? false
        isWithBitmojiAvatarId = map["isWithBitmojiAvatarId"] as? Bool ?? false
        isWithBitmojiAvatarUrl = map["isWithBitmojiAvatarUrl"] as? Bool ?? false
    }
    
    
    // MARK: - Functions -
    
    func prepareUserDataQuery() -> SCSDKUserDataQuery {
        let builder = SCSDKUserDataQueryBuilder()
        
        if (isWithDisplayName) {
            builder.withDisplayName()
        }
        if (isWithExternalId) {
            builder.withExternalId()
        }
        if (isWithIdToken) {
            builder.withIdToken()
        }
        if (isWithProfileLink) {
            builder.withProfileLink()
        }
        if (isWithBitmojiAvatarId) {
            builder.withBitmojiAvatarID()
        }
        if (isWithBitmojiAvatarUrl) {
            builder.withBitmojiTwoDAvatarUrl()
        }
        
        return builder.build()
    }
}
