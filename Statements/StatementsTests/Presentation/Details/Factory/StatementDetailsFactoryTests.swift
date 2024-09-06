//
//  StatementDetailsFactoryTests.swift
//  StatementsTests
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation
import Statements
import XCTest

final class StatementDetailsFactoryTests: XCTestCase {
    func test_make_ShouldReturnAValidViewController() {
        let id = "something"
        
        let result = StatementDetailsFactory.make(id: id)
        
        XCTAssertNotNil(result as? StatementDetailsViewController)
    }
}
