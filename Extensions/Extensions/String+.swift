//
//  String+.swift
//  Extensions
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation

public extension String {
    func toCPF() -> String {
        let numbers = self.filter { "0"..."9" ~= $0 }
        
        let maxLength = 11
        let limitedNumbers = String(numbers.prefix(maxLength))
        
        var formatted = ""
        for (index, character) in limitedNumbers.enumerated() {
            if index == 3 || index == 6 {
                formatted.append(".")
            } else if index == 9 {
                formatted.append("-")
            }
            formatted.append(character)
        }
        
        return formatted
    }
    
    func toCNPJ() -> String {
        let numbersOnly = self.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)

        guard numbersOnly.count == 14 else {
            return self
        }

        let formattedCNPJ = numbersOnly.replacingOccurrences(of: "(\\d{2})(\\d{3})(\\d{3})(\\d{4})(\\d{2})", with: "$1.$2.$3/$4-$5", options: .regularExpression)
        
        return formattedCNPJ
    }
}
