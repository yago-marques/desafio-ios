//
//  Defaults.swift
//  Storage
//
//  Created by Yago Marques on 30/08/24.
//

import Foundation

public protocol DefaultsContract {
    func setItem(_ item: Any, for key: DefaultsKeys)
    func getItem(for key: DefaultsKeys) -> Any?
}

public class Defaults: DefaultsContract {
    public static let shared = Defaults()
    
    private init() { }
    
    public func setItem(_ item: Any, for key: DefaultsKeys) {
        UserDefaults.standard.setValue(item, forKey: key.rawValue)
    }
    
    public func getItem(for key: DefaultsKeys) -> Any? {
        UserDefaults.standard.value(forKey: key.rawValue)
    }
}
