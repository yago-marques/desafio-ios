//
//  LoginFactoryTests.swift
//  LoginTests
//
//  Created by Yago Marques on 04/09/24.
//

import Foundation
import XCTest
import Login
import SwiftUI

final class LoginFactoryTests: XCTestCase {
    
    func test_Make_WithCoordinator_ShouldReturnLoginView() {
        let view = LoginFactory.make(coordinator: CoordinatingSpy())
        
        XCTAssertNotNil(view as? LoginView)
    }
    
}
