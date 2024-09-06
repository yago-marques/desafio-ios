//
//  Date+.swift
//  Extensions
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation

public extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE - d 'de' MMMM"
        formatter.locale = Locale(identifier: "pt_BR") // Define o idioma para português
        
        return formatter.string(from: self)
    }
    
    func toHourMinuteString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // Define o formato para hora:minuto
        formatter.locale = Locale(identifier: "pt_BR") // Define o idioma para português
        
        return formatter.string(from: self)
    }
    
    static func fromISOString(_ isoString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Define o formato para correspondência exata
        formatter.locale = Locale(identifier: "en_US_POSIX") // Define o locale para garantir consistência no parsing
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // Define o fuso horário como UTC
        
        return formatter.date(from: isoString)
    }
    
    static func dateFromString(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Define o formato da data

        return formatter.date(from: dateString)
    }
}
