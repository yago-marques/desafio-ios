//
//  BusinessStatement.swift
//  Statements
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation

public enum BusinessStatementEntry: String {
    case debit = "DEBIT"
    case credit = "CREDIT"
    case none
}

public struct BusinessStatement {
    public let id: String
    public let description: String
    public let label: String
    public let type: BusinessStatementEntry
    public let amount: String
    public let name: String
    public let dateEvent: String?
    public let status: String
    
    public init(id: String, description: String, label: String, type: BusinessStatementEntry, amount: String, name: String, dateEvent: String?, status: String) {
        self.id = id
        self.description = description
        self.label = label
        self.type = type
        self.amount = amount
        self.name = name
        self.dateEvent = dateEvent
        self.status = status
    }
}
