//
//  StatementsViewModelTests.swift
//  StatementsTests
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation
import Statements
import XCTest

typealias StatementsViewModelSUT = (
    sut: StatementsViewModel,
    doubles: (
        coordinator: StatementsCoordinatorSpy,
        useCases: StatementUseCaseMock,
        viewController: StatementsViewControllerSpy
    )
)

final class StatementsViewModelTests: XCTestCase {
    func test_fetchStatements_WhenNotThrowError_ShouldPopulateTableAndHideSkeleton() async {
        let (sut, doubles) = makeSUT()
        
        await sut.fetchStatements()
        
        XCTAssertEqual(
            doubles.viewController.receivedMessages,
            [.reloadTableCalled, .hideSkeletonCalled]
        )
        XCTAssertNotNil(sut.presentedStatements)
    }
    
    func test_fetchStatements_WhenThrowError_ShouldShowErrorAlertAndHideSkeleton() async {
        let (sut, doubles) = makeSUT()
        doubles.useCases.shouldThrowError = true
        
        await sut.fetchStatements()
        
        XCTAssertEqual(
            doubles.viewController.receivedMessages,
            [.showErrorAlertCalled, .hideSkeletonCalled]
        )
    }
    
    func test_refreshStatements_WhenNotThrowError_ShouldShowSkeletonAndRefreshContent() async {
        let (sut, doubles) = makeSUT()
        
        await sut.refreshStatements()
        
        XCTAssertEqual(
            doubles.viewController.receivedMessages,
            [.showSkeletonCalled, .reloadTableCalled, .hideSkeletonCalled, .setFilterToAllCalled]
        )
    }
    
    func test_refreshStatements_WhenThrowError_ShouldShowSkeletonAndShowErrorAlert() async {
        let (sut, doubles) = makeSUT()
        doubles.useCases.shouldThrowError = true
        
        await sut.refreshStatements()
        
        XCTAssertEqual(
            doubles.viewController.receivedMessages,
            [.showSkeletonCalled, .showErrorAlertCalled, .hideSkeletonCalled, .setFilterToAllCalled]
        )
    }
    
    func test_openDetails_ShouldCallCoordinatorWithValidID() {
        let (sut, doubles) = makeSUT()
        let id = "teste"
        
        sut.openDetails(of: id)
        
        XCTAssertTrue(doubles.coordinator.openDetailsCalled.boolean)
        XCTAssertEqual(doubles.coordinator.openDetailsCalled.id, id)
    }
    
    func test_showAllStatements_ShouldInsertAllStatementsInPresentedStatements() {
        let (sut, _) = makeSUT()
        sut.statements = mockedStatementGroupWithTwoDebitsAndOneCredit()
        
        sut.showAllStatements()
        
        XCTAssertEqual(3, sut.presentedStatements?.group.count)
    }
    
    func test_filterStatements_WhenFilterIsCredit_ShouldPresentGroupWithOnlyCredits() {
        let (sut, _) = makeSUT()
        sut.statements = mockedStatementGroupWithTwoDebitsAndOneCredit()
        
        sut.filterStatements(by: .credit)
        
        XCTAssertEqual(sut.presentedStatements?.group.count, 1)
    }
    
    func test_filterStatements_WhenFilterIsDebit_ShouldPresentGroupWithOnlyDebits() {
        let (sut, _) = makeSUT()
        sut.statements = mockedStatementGroupWithTwoDebitsAndOneCredit()
        
        sut.filterStatements(by: .debit)
        
        XCTAssertEqual(sut.presentedStatements?.group.count, 2)
    }
    
    func test_filterStatements_WhenDontHaveItemWithFilter_ShouldPresentEmptyGroup() {
        let (sut, _) = makeSUT()
        sut.statements = mockedStatementGroupWithTwoDebits()
        
        sut.filterStatements(by: .credit)
        
        XCTAssertEqual(sut.presentedStatements?.group.count, 0)
    }
}

private extension StatementsViewModelTests {
    func makeSUT() -> StatementsViewModelSUT {
        let coordinator = StatementsCoordinatorSpy()
        let viewController = StatementsViewControllerSpy()
        let useCases = StatementUseCaseMock()
        let sut = StatementsViewModel(useCases: useCases, coordinator: coordinator)
        sut.viewController = viewController
        
        return (sut, (coordinator, useCases, viewController))
    }
    
    func mockedStatementGroupWithTwoDebitsAndOneCredit() -> BusinessStatementsGroup {
        .init(
            group: [
                .init(
                    statements: [
                        .init(
                            id: "id",
                            description: "description",
                            label: "label",
                            type: .credit,
                            amount: "R$ 100,00",
                            name: "name",
                            dateEvent: "10 de agosto",
                            status: "completed"
                        )
                    ],
                    date: "04/04/2024"
                ),
                .init(
                    statements: [
                        .init(
                            id: "id",
                            description: "description",
                            label: "label",
                            type: .debit,
                            amount: "R$ 100,00",
                            name: "name",
                            dateEvent: "10 de agosto",
                            status: "completed"
                        )
                    ],
                    date: "04/04/2024"
                ),
                .init(
                    statements: [
                        .init(
                            id: "id",
                            description: "description",
                            label: "label",
                            type: .debit,
                            amount: "R$ 100,00",
                            name: "name",
                            dateEvent: "10 de agosto",
                            status: "completed"
                        )
                    ],
                    date: "04/04/2024"
                )
            ]
        )
    }
    
    func mockedStatementGroupWithTwoDebits() -> BusinessStatementsGroup {
        .init(
            group: [
                .init(
                    statements: [
                        .init(
                            id: "id",
                            description: "description",
                            label: "label",
                            type: .debit,
                            amount: "R$ 100,00",
                            name: "name",
                            dateEvent: "10 de agosto",
                            status: "completed"
                        )
                    ],
                    date: "04/04/2024"
                ),
                .init(
                    statements: [
                        .init(
                            id: "id",
                            description: "description",
                            label: "label",
                            type: .debit,
                            amount: "R$ 100,00",
                            name: "name",
                            dateEvent: "10 de agosto",
                            status: "completed"
                        )
                    ],
                    date: "04/04/2024"
                )
            ]
        )
    }
}
