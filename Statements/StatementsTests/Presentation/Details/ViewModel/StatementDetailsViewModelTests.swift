//
//  StatementDetailsViewModelTests.swift
//  StatementsTests
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation
import Statements
import XCTest

typealias StatementDetailsViewModelSUT = (
    sut: StatementDetailsViewModel,
    doubles: (
        useCases: StatementDetailsUseCasesMock,
        viewController: StatementDetailViewControllerSpy
    )
)

final class StatementDetailsViewModelTests: XCTestCase {
    
    func test_fetchDetails_WhenCompletionIsSuccess_ShouldConfigureViewWithContent() {
        let (sut, doubles) = makeSUT()
        
        sut.fetchDetails()
        
        XCTAssertEqual(
            doubles.viewController.receivedMessages,
            [.showSkeletonCalled, .configureCalled, .hideSkeletonCalled]
        )
    }
    
    func test_fetchDetails_WhenCompletionIsFailure_ShouldShowErrorAlert() {
        let (sut, doubles) = makeSUT()
        doubles.useCases.shouldCompletionFailure = true
        
        sut.fetchDetails()
        
        XCTAssertEqual(
            doubles.viewController.receivedMessages,
            [.showSkeletonCalled, .hideSkeletonCalled, .showErrorAlertCalled]
        )
    }
    
}

private extension StatementDetailsViewModelTests {
    func makeSUT() -> StatementDetailsViewModelSUT {
        let useCase = StatementDetailsUseCasesMock()
        let viewModel = StatementDetailsViewModel(useCases: useCase, statementID: "")
        let viewController = StatementDetailViewControllerSpy()
        viewModel.viewController = viewController
        
        return (viewModel, (useCase, viewController))
    }
}
