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
}
