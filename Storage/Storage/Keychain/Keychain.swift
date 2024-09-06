//
//  Keychain.swift
//  Storage
//
//  Created by Yago Marques on 30/08/24.
//

import Foundation

public protocol KeychainContract {
    func setItem(_ item: Any, for key: KeychainKeys)
    func getItem(for key: KeychainKeys) -> Any?
}

public class Keychain: KeychainContract {
    public static let shared = Keychain()
    
    private init() { }
    
    public func setItem(_ item: Any, for key: KeychainKeys) {
        addKeychainItem(key: key.rawValue, value: item)
    }
    
    public func getItem(for key: KeychainKeys) -> Any? {
        getKeychainItem(key: key.rawValue)
    }
}

private extension Keychain {
    @discardableResult
    func addKeychainItem(key: String, value: Any) -> Bool {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false) else {
            return false
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)

        if status == errSecDuplicateItem {
            let updateQuery: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key
            ]
            
            let updateAttributes: [String: Any] = [
                kSecValueData as String: data
            ]
            
            let updateStatus = SecItemUpdate(updateQuery as CFDictionary, updateAttributes as CFDictionary)
            return updateStatus == errSecSuccess
        }

        return status == errSecSuccess
    }
    
    func getKeychainItem(key: String) -> Any? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess, let data = item as? Data else {
            return nil
        }

        do {
            let value = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSString.self, NSDictionary.self, NSArray.self, NSNumber.self, NSDate.self], from: data)
            return value
        } catch {
            return nil
        }
    }
}
