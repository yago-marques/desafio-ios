//
//  Double+.swift
//  Extensions
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation

public extension Double {
    func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR") // Define o idioma para português do Brasil
        formatter.currencySymbol = "R$" // Define o símbolo da moeda
        
        return formatter.string(from: NSNumber(value: self)) ?? "R$ 0,00"
    }
}
