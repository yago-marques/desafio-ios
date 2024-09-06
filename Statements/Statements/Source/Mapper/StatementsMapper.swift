//
//  StatementsMapper.swift
//  Statements
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation
import Extensions

public struct StatementsMapper {
    public static let shared = StatementsMapper()
    
    private init() { }
    
    public func toBusiness(from remoteModel: RemoteStatementsGroup) -> BusinessStatementsGroup {
        .init(
            group: remoteModel.results.map { remoteStatements in
                let bussinessStatements: [BusinessStatement] = remoteStatements.items.map { remoteStatement in
                        .init(
                            id: remoteStatement.id,
                            description: remoteStatement.description,
                            label: remoteStatement.label,
                            type: .init(rawValue: remoteStatement.entry) ?? .none,
                            amount: remoteStatement.amount.toCurrency(),
                            name: remoteStatement.name,
                            dateEvent: Date.fromISOString(remoteStatement.dateEvent)?.toHourMinuteString(),
                            status: remoteStatement.status
                        )
                }
                
                return .init(
                    statements: bussinessStatements,
                    date: Date.dateFromString(remoteStatements.date)?.formattedString()
                )
            }
        )
    }
}
