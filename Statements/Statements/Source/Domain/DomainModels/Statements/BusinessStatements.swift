//
//  BusinessStatements.swift
//  Statements
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation

public struct BusinessStatements {
    public let statements: [BusinessStatement]
    public let date: String?
    
    public init(statements: [BusinessStatement], date: String?) {
        self.statements = statements
        self.date = date
    }
}
