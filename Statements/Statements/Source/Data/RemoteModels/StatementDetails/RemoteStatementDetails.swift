//
//  RemoteStatementDetails.swift
//  Statements
//
//  Created by Yago Marques on 02/09/24.
//

import Foundation

public struct RemoteStatementDetails: Decodable {
    public let description: String
    public let label: String
    public let amount: Double
    public let dateEvent: String
    public let recipient: RemotePaymentDetail
    public let sender: RemotePaymentDetail
}
