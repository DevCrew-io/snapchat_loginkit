//
//  Method.swift
//  snapchat_loginkit
//
//  Created by Najam Us Saqib on 14/02/2024.
//

import Foundation

enum Method {
    static let login = "login"
    static let addLoginStateCallback = "addLoginStateCallback"
    static let removeLoginStateCallback = "removeLoginStateCallback"
    static let logout = "logout"
    static let isUserLoggedIn = "isUserLoggedIn"
    static let fetchUserData = "fetchUserData"
    static let fetchAccessToken = "fetchAccessToken"
    static let hasAccessToScope = "hasAccessToScope"

    enum Callback {
        static let onStart = "onStart"
        static let onSuccess = "onSuccess"
        static let onFailure = "onFailure"
        static let onLogout = "onLogout"
    }
}
