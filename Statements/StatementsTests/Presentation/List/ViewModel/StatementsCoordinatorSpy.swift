//
//  StatementsCoordinatorSpy.swift
//  StatementsTests
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation
import Statements

final class StatementsCoordinatorSpy: StatementsCoordinating {
    var openDetailsCalled: (boolean: Bool, id: String) = (false, "")
    
    func openDetails(of id: String) {
        openDetailsCalled = (true, id)
    }
}
