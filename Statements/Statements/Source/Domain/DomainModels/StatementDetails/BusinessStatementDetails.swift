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
}
