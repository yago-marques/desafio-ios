import Foundation
import SwiftUI
import UIKit
import Storage

public typealias LoginViewModelUseCases = LoginAuthUseCase

public final class LoginViewModel: ObservableObject {
    private let coordinator: LoginCoordinating
    private let useCases: LoginViewModelUseCases
    private let keychain: KeychainContract
    private let defaults: DefaultsContract
    
    @Published public var buttonCPFPickerIsEnabled = false
    @Published public var buttonPasswordPickerIsEnabled = false
    @Published public var showLoginErrorMessage = false
    @Published public var cpf = ""
    @Published public var password = ""
    
    public init(
        coordinator: LoginCoordinating,
        useCases: LoginViewModelUseCases,
        keychain: KeychainContract = Keychain.shared,
        defaults: DefaultsContract = Defaults.shared
    ) {
        self.coordinator = coordinator
        self.useCases = useCases
        self.keychain = keychain
        self.defaults = defaults
    }
}

extension LoginViewModel {
    @MainActor
    public func login() async {
        do {
            let response = try await useCases.executeLoginAuth(with: .init(cpf: cpfNumbers(), password: password))
            savePrivateToken(response.token)
            registerLoggedUser()
            openStatements()
        } catch {
            showLoginErrorMessage = true
        }
    }
}

// MARK: Field Validators handlers
extension LoginViewModel {
    @MainActor
    public func cpfFieldValidator() {
        buttonCPFPickerIsEnabled = isValidCPF()
    }
    
    @MainActor
    public func passwordFieldValidator() {
        buttonPasswordPickerIsEnabled = password.count == 6
    }
    
    public func isValidCPF() -> Bool {
        let numbers = cpf.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard numbers.count == 11 else { return false }
        
        let set = NSCountedSet(array: Array(numbers))
        guard set.count != 1 else { return false }
        
        let i1 = numbers.index(numbers.startIndex, offsetBy: 9)
        let i2 = numbers.index(numbers.startIndex, offsetBy: 10)
        let i3 = numbers.index(numbers.startIndex, offsetBy: 11)
        let d1 = Int(numbers[i1..<i2])
        let d2 = Int(numbers[i2..<i3])
        
        var temp1 = 0, temp2 = 0
        
        for i in 0...8 {
            let start = numbers.index(numbers.startIndex, offsetBy: i)
            let end = numbers.index(numbers.startIndex, offsetBy: i+1)
            let char = Int(numbers[start..<end])
            
            temp1 += char! * (10 - i)
            temp2 += char! * (11 - i)
        }
        
        temp1 %= 11
        temp1 = temp1 < 2 ? 0 : 11-temp1
        
        temp2 += temp1 * 2
        temp2 %= 11
        temp2 = temp2 < 2 ? 0 : 11-temp2
        
        return temp1 == d1 && temp2 == d2
    }
    
    
}

// MARK: Coordinator Handlers
extension LoginViewModel {
    public func openCpfPicker() {
        coordinator.openCpfPicker(viewModel: self)
    }
    
    public func openPasswordPicker() {
        coordinator.openPasswordPicker(viewModel: self)
    }
    
    public func pop() {
        coordinator.pop()
    }
    
    public func openStatements() {
        coordinator.openStatements()
    }
}

// MARK: Formatter
extension LoginViewModel {
    public func formatCPF(_ cpf: String) -> String {
        let numbers = cpf.filter { "0"..."9" ~= $0 }
        
        let maxLength = 11
        let limitedNumbers = String(numbers.prefix(maxLength))
        
        var formatted = ""
        for (index, character) in limitedNumbers.enumerated() {
            if index == 3 || index == 6 {
                formatted.append(".")
            } else if index == 9 {
                formatted.append("-")
            }
            formatted.append(character)
        }
        
        return formatted
    }
    
    public func formatPassword(_ value: String) -> String {
        if value.count <= 6 {
            return value
        } else {
            return String(value.prefix(6))
        }
    }
}

// MARK: Private functions
private extension LoginViewModel {
    func cpfNumbers() -> String {
        cpf.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    func savePrivateToken(_ token: String) {
        keychain.setItem(token, for: .token)
        keychain.setItem(Date(), for: .tokenDate)
    }
    
    func registerLoggedUser() {
        defaults.setItem(true, for: .logged)
    }
}
