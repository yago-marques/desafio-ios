//
//  StatementDetailViewControllerSpy.swift
//  StatementsTests
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation
import Statements

final class StatementDetailViewControllerSpy: StatementDetailsViewControllerDisplay {
    enum Message: Equatable {
        case showSkeletonCalled
        case hideSkeletonCalled
        case configureCalled
        case showErrorAlertCalled
    }
    
    var receivedMessages = [Message]()
    
    func showSkeleton() {
        receivedMessages.append(.showSkeletonCalled)
    }
    
    func hideSkeleton() {
        receivedMessages.append(.hideSkeletonCalled)
    }
    
    func configure(with: BusinessStatementDetails) {
        receivedMessages.append(.configureCalled)
    }
    
    func showErrorAlert() {
        receivedMessages.append(.showErrorAlertCalled)
    }
}
