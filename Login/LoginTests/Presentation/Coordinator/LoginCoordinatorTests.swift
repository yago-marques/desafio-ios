//
//  LoginCoordinatorTests.swift
//  LoginTests
//
//  Created by Yago Marques on 04/09/24.
//

import Foundation
import Login
import XCTest

typealias LoginCoordinatorSUT = (
    sut: LoginCoordinator,
    appCoordinator: CoordinatingSpy
)

final class LoginCoordinatorTests: XCTestCase {
    
    //MARK: openCpfPicker
    func test_OpenCpfPicker_ShouldCallPushOnAppCoordinator() {
        let (sut, appCoordinator) = makeSUT()
        let viewModel = LoginViewModelTests().makeSUT().sut
        
        sut.openCpfPicker(viewModel: viewModel)
        
        XCTAssertEqual(appCoordinator.receivedMessages, [.pushCalled])
    }
    
    //MARK: openPasswordPicker
    func test_OpenPasswordPicker_ShouldCallPushOnAppCoordinator() {
        let (sut, appCoordinator) = makeSUT()
        let viewModel = LoginViewModelTests().makeSUT().sut
        
        sut.openPasswordPicker(viewModel: viewModel)
        
        XCTAssertEqual(appCoordinator.receivedMessages, [.pushCalled])
    }
    
    //MARK: openStatements
    func test_OpenStatements_ShouldCallPushOnAppCoordinator() {
        let (sut, appCoordinator) = makeSUT()
        
        sut.openStatements()
        
        XCTAssertEqual(appCoordinator.receivedMessages, [.pushCalled])
    }
    
    //MARK: pop
    func test_OpenStatements_ShouldCallPopOnAppCoordinator() {
        let (sut, appCoordinator) = makeSUT()
        
        sut.pop()
        
        XCTAssertEqual(appCoordinator.receivedMessages, [.popCalled])
    }
}

private extension LoginCoordinatorTests {
    func makeSUT() -> LoginCoordinatorSUT {
        let appCoordinator = CoordinatingSpy()
        let sut = LoginCoordinator(coordinator: appCoordinator)
        
        return (sut, appCoordinator)
    }
}
