//
//  RemoteStatementsGroup.swift
//  Statements
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation

public struct RemoteStatementsGroup: Decodable {
    public let results: [RemoteStatements]
}
