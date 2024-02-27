//
//  Protocol.swift
//  integration_test
//
//  Created by Najam Us Saqib on 26/02/2024.
//

import Foundation

// MARK: - SnapchatResponse Protocol -

protocol SnapchatResponse {    
    var code: Int { get }
    var message: String { get }
    
    func toMap() -> [String : Any?]
}

