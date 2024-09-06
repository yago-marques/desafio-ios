//
//  StatementDetails.swift
//  Statements
//
//  Created by Yago Marques on 02/09/24.
//

import Foundation

public struct BusinessStatementDetails {
    public let description: String
    public let label: String
    public let amount: String
    public let dateEvent: String
    public let recipient: BusinessPaymentDetail
    public let sender: BusinessPaymentDetail
    
    public init(description: String, label: String, amount: String, dateEvent: String, recipient: BusinessPaymentDetail, sender: BusinessPaymentDetail) {
        self.description = description
        self.label = label
        self.amount = amount
        self.dateEvent = dateEvent
        self.recipient = recipient
        self.sender = sender
    }
}
