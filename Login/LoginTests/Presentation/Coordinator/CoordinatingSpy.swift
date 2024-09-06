//
//  CoordinatingSpy.swift
//  LoginTests
//
//  Created by Yago Marques on 04/09/24.
//

import Foundation
import Coordinator

final class CoordinatingSpy: Coordinating {
    enum Message: Equatable {
        case popCalled
        case pushCalled
    }
    
    var receivedMessages = [Message]()
    
    func send(_ actions: CoordinatorActions) {
        switch actions {
        case .push(_):
            receivedMessages.append(.pushCalled)
        case .pop:
            receivedMessages.append(.popCalled)
        }
    }
}
