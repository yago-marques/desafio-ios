//
//  LoginViewModelTests.swift
//  LoginTests
//
//  Created by Yago Marques on 03/09/24.
//

import Foundation
import Login
import XCTest

typealias LoginViewModelSUT = (
    sut: LoginViewModel,
    doubles: (
        coordinator: LoginCoordinatorSpy,
        useCases: LoginUseCasesMock,
        keychain: KeychainSpy,
        defaults: DefaultsSpy
    )
)

final class LoginViewModelTests: XCTestCase {
    
    // MARK: Login
    func test_Login_ShouldCallUseCaseMethod() async {
        let (sut, (_, useCases, _, _)) = makeSUT()
        
        await sut.login()
        
        XCTAssertTrue(useCases.executeLoginAuthCalled)
    }
    
    func test_Login_WhenResponseIsCorrect_ShouldSaveTokenAndTokenDate() async {
        let (sut, (_, _, keychain, _)) = makeSUT()
        
        await sut.login()
        
        XCTAssertEqual(keychain.receivedMessages, [.setItem(key: "token"), .setItem(key: "tokenDate")])
    }
    
    func test_Login_WhenResponseIsCorrect_ShouldRegisterLoggedUser() async {
        let (sut, (_, _, _, defaults)) = makeSUT()
        
        await sut.login()
        
        XCTAssertEqual(defaults.receivedMessages, [.setItem(key: "logged")])
    }
    
    func test_Login_WhenResponseIsCorrect_ShouldOpenStatements() async {
        let (sut, (coordinator, _, _, _)) = makeSUT()
        
        await sut.login()
        
        XCTAssertEqual(coordinator.receivedMessages, [.openStatementsCalled])
    }
    
    func test_Login_WhenCallReturnError_ShouldShowErrorAlert() async {
        let (sut, (_, useCases, _, _)) = makeSUT()
        useCases.shouldThrowError = true
        
        await sut.login()
        
        XCTAssertTrue(sut.showLoginErrorMessage)
    }
    
    // MARK: isValidCPF
    func test_IsValidCPF_WhenCPFIsCorrect_ShouldReturnTrue() {
        let (sut, _) = makeSUT()
        sut.cpf = "165.053.710-79"
        
        let result = sut.isValidCPF()
        
        XCTAssertTrue(result)
    }
    
    func test_IsValidCPF_WhenCPFIsCorrectWithoutMask_ShouldReturnTrue() {
        let (sut, _) = makeSUT()
        sut.cpf = "16505371079"
        
        let result = sut.isValidCPF()
        
        XCTAssertTrue(result)
    }
    
    func test_IsValidCPF_WhenCPFHaveMoreThan11Digits_ShouldReturnFalse() {
        let (sut, _) = makeSUT()
        sut.cpf = "165.053.710-7911"
        
        let result = sut.isValidCPF()
        
        XCTAssertFalse(result)
    }
    
    func test_IsValidCPF_WhenCPFHaveLessThan11Digits_ShouldReturnFalse() {
        let (sut, _) = makeSUT()
        sut.cpf = "165.053.710-7"
        
        let result = sut.isValidCPF()
        
        XCTAssertFalse(result)
    }
    
    // MARK: cpfFieldValidator
    func test_CpfFieldValidator_WhenCPFIsValid_ShouldEnableNextButton() async {
        let (sut, _) = makeSUT()
        sut.cpf = "165.053.710-79"
        
        await sut.cpfFieldValidator()
        
        XCTAssertTrue(sut.buttonCPFPickerIsEnabled)
    }
    
    func test_CpfFieldValidator_WhenCPFIsInvalid_ShouldNotEnableNextButton() async {
        let (sut, _) = makeSUT()
        sut.cpf = "165.053.710-77"
        
        await sut.cpfFieldValidator()
        
        XCTAssertFalse(sut.buttonCPFPickerIsEnabled)
    }
    
    // MARK: passwordFieldValidator
    func test_PasswordFieldValidator_WhenPasswordHave6Digits_ShouldEnableNextButton() async {
        let (sut, _) = makeSUT()
        sut.password = "xXxXxX"
        
        await sut.passwordFieldValidator()
        
        XCTAssertTrue(sut.buttonPasswordPickerIsEnabled)
    }
    
    func test_PasswordFieldValidator_WhenPasswordHaveLessThan6Digits_ShouldNotEnableNextButton() async {
        let (sut, _) = makeSUT()
        sut.password = "xXxXx"
        
        await sut.passwordFieldValidator()
        
        XCTAssertFalse(sut.buttonPasswordPickerIsEnabled)
    }
    
    // MARK: formatCPF
    func test_FormatCPF_WhenCPFHave11Digits_ShouldReturnFormatedCPF() {
        let (sut, _) = makeSUT()
        let rawCpf = "11111111111"
        
        let result = sut.formatCPF(rawCpf)
        
        XCTAssertEqual(result, "111.111.111-11")
    }
    
    func test_FormatCPF_WhenCPFHaveLessThan11Digits_ShouldReturnPossibleFormatedCPF() {
        let (sut, _) = makeSUT()
        let rawCpf = "1234567"
        
        let result = sut.formatCPF(rawCpf)
        
        XCTAssertEqual(result, "123.456.7")
    }
    
    func test_FormatCPF_WhenCPFHaveMoreThan11Digits_ShouldReturnFormatedCPFUpTo11Digits() {
        let (sut, _) = makeSUT()
        let rawCpf = "1234567891011"
        
        let result = sut.formatCPF(rawCpf)
        
        XCTAssertEqual(result, "123.456.789-10")
    }
    
    // MARK: formatPassword
    func test_FormatPassword_WhenPassHave6Digits_ShouldReturnPassword() {
        let (sut, _) = makeSUT()
        let password = "123456"
        
        let result = sut.formatPassword(password)
        
        XCTAssertEqual(result, password)
    }
    
    func test_FormatPassword_WhenPassHaveLessThan6Digits_ShouldReturnPassword() {
        let (sut, _) = makeSUT()
        let password = "12345"
        
        let result = sut.formatPassword(password)
        
        XCTAssertEqual(result, password)
    }
    
    func test_FormatPassword_WhenPassHaveMoreThan6Digits_ShouldReturnPasswordUpTo6Digits() {
        let (sut, _) = makeSUT()
        let password = "12345678"
        
        let result = sut.formatPassword(password)
        
        XCTAssertEqual(result, "123456")
    }
    
    // MARK: openCpfPicker
    func test_OpenCpfPicker_ShouldCallCoordinator() {
        let (sut, (coordinator, _, _, _)) = makeSUT()
        
        sut.openCpfPicker()
        
        XCTAssertEqual(coordinator.receivedMessages, [.openCpfPickerCalled])
    }
    
    // MARK: openPasswordPicker
    func test_OpenPasswordPicker_ShouldCallCoordinator() {
        let (sut, (coordinator, _, _, _)) = makeSUT()
        
        sut.openPasswordPicker()
        
        XCTAssertEqual(coordinator.receivedMessages, [.openPasswordPickerCalled])
    }
    
    // MARK: openStatements
    func test_OpenStatements_ShouldCallCoordinator() {
        let (sut, (coordinator, _, _, _)) = makeSUT()
        
        sut.openStatements()
        
        XCTAssertEqual(coordinator.receivedMessages, [.openStatementsCalled])
    }
    
    // MARK: pop
    func test_Pop_ShouldCallCoordinator() {
        let (sut, (coordinator, _, _, _)) = makeSUT()
        
        sut.pop()
        
        XCTAssertEqual(coordinator.receivedMessages, [.popCalled])
    }
}

extension LoginViewModelTests {
    func makeSUT() -> LoginViewModelSUT {
        let useCases = LoginUseCasesMock()
        let coordinator = LoginCoordinatorSpy()
        let keychain = KeychainSpy()
        let defaults = DefaultsSpy()
        let viewModel = LoginViewModel(
            coordinator: coordinator,
            useCases: useCases,
            keychain: keychain,
            defaults: defaults
        )
        
        return (viewModel, (coordinator, useCases, keychain, defaults))
    }
}
