//
//  BusinessPaymentDetail.swift
//  Statements
//
//  Created by Yago Marques on 02/09/24.
//

import Foundation

public enum DocumentType: String {
    case cpf = "CPF"
    case cnpj = "CNPJ"
    case none
}

public struct BusinessPaymentDetail {
    public let bankName: String
    public let documentType: DocumentType
    public let documentNumber: String
    public let accountNumber: String
    public let agencyNumber: String
    public let name: String
    
    public init(bankName: String, documentType: DocumentType, documentNumber: String, accountNumber: String, agencyNumber: String, name: String) {
        self.bankName = bankName
        self.documentType = documentType
        self.documentNumber = documentNumber
        self.accountNumber = accountNumber
        self.agencyNumber = agencyNumber
        self.name = name
    }
}
