//
//  RemotePaymentDetail.swift
//  Statements
//
//  Created by Yago Marques on 02/09/24.
//

import Foundation


public struct RemotePaymentDetail: Decodable {
    public let bankName: String
    public let documentType: String
    public let documentNumber: String
    public let accountNumber: String
    public let agencyNumber: String
    public let accountNumberDigit: String
    public let agencyNumberDigit: String
    public let name: String
}
