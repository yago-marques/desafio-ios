//
//  RemoteStatements.swift
//  Statements
//
//  Created by Yago Marques on 31/08/24.
//

import Foundation

public struct RemoteStatements: Decodable {
    public let items: [RemoteStatement]
    public let date: String
}
