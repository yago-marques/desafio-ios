//
//  StatementDetailsMapper.swift
//  Statements
//
//  Created by Yago Marques on 02/09/24.
//

import Foundation
import Extensions

public struct StatementDetailsMapper {
    public static let shared = StatementDetailsMapper()
    
    private init() { }
    
    public func toBusiness(from remote: RemoteStatementDetails) -> BusinessStatementDetails {
        .init(
            description: remote.description,
            label: remote.label,
            amount: remote.amount.toCurrency(),
            dateEvent: Date.fromISOString(remote.dateEvent)?.formattedString() ?? "--",
            recipient: .init(
                bankName: remote.recipient.bankName,
                documentType: .init(rawValue: remote.recipient.documentType) ?? .none,
                documentNumber: remote.recipient.documentNumber,
                accountNumber: "\(remote.recipient.accountNumber)-\(remote.recipient.accountNumberDigit)",
                agencyNumber: "\(remote.recipient.agencyNumber)-\(remote.recipient.agencyNumberDigit)",
                name: remote.recipient.name
            ),
            sender: .init(
                bankName: remote.sender.bankName,
                documentType: .init(rawValue: remote.sender.documentType) ?? .none,
                documentNumber: remote.sender.documentNumber,
                accountNumber: "\(remote.sender.accountNumber)-\(remote.sender.accountNumberDigit)",
                agencyNumber: "\(remote.sender.agencyNumber)-\(remote.sender.agencyNumberDigit)",
                name: remote.sender.name
            )
        )
    }
}
