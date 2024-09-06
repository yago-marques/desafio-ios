//
//  StatementsViewControllerSpy.swift
//  StatementsTests
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation
import Statements

final class StatementsViewControllerSpy: StatementsViewControllerDisplay {
    enum Message: Equatable {
        case showSkeletonCalled
        case hideSkeletonCalled
        case reloadTableCalled
        case setFilterToAllCalled
        case showErrorAlertCalled
    }
    
    var receivedMessages = [Message]()
    
    func showSkeleton() {
        receivedMessages.append(.showSkeletonCalled)
    }
    
    func hideSkeleton() {
        receivedMessages.append(.hideSkeletonCalled)
    }
    
    func reloadTable() {
        receivedMessages.append(.reloadTableCalled)
    }
    
    func setFilterToAll() {
        receivedMessages.append(.setFilterToAllCalled)
    }
    
    func showErrorAlert() {
        receivedMessages.append(.showErrorAlertCalled)
    }
}
