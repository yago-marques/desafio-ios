//
//  RemoteStatement.swift
//  Statements
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation

public struct RemoteStatement: Decodable {
    public let id: String
    public let description: String
    public let label: String
    public let entry: String
    public let amount: Double
    public let name: String
    public let dateEvent: String
    public let status: String
}
