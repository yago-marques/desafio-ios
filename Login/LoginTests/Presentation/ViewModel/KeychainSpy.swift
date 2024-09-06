//
//  KeychainSpy.swift
//  LoginTests
//
//  Created by Yago Marques on 03/09/24.
//

import Foundation
import Storage

final class KeychainSpy: KeychainContract {
    enum Message: Equatable {
        case setItem(key: String)
        case getItem(key: String)
    }
    
    var receivedMessages = [Message]()
        
    func setItem(_ item: Any, for key: KeychainKeys) {
        receivedMessages.append(.setItem(key: key.rawValue))
    }
    
    func getItem(for key: KeychainKeys) -> Any? {
        receivedMessages.append(.getItem(key: key.rawValue))
    }
}
