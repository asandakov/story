//
//  ErrorNetworkCore.swift
//  florews
//
//  Created by Алексей on 18.12.2020.
//

import Foundation

enum ErrorNetworkCore: Error {
   
    case network(description: String)
    case api(description: String)
    case failure(description: String)
    case invalidType(expect: Any.Type, got: Any.Type)
    case invalidToken
    
}

extension ErrorNetworkCore: LocalizedError {
 
    var errorDescription: String? {
        switch self {
        case let .api(description: description):
            return description
        case let .network(description):
            return description
        case let .failure(description):
            return description
        case .invalidType(_, _):
            return ""
        case .invalidToken:
            return "Ошибка авторизации"
        }
    }
}



