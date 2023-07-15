//
//  PersistUD.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 16.07.2023.
//

import Foundation

@propertyWrapper
struct PersistUD<T: Codable> {
    let key: String
    let defaultValue: T
    
    var _wrappedValue: T?
    
    var wrappedValue: T {
        mutating get {
            if let value = _wrappedValue,
               !((value as? OptionalProtocol)?.isNil ?? false) {
                return value
            }
            
            if let data = UserDefaults.standard.object(forKey: key) as? T,
               !((data as? OptionalProtocol)?.isNil ?? false) {
                _wrappedValue = data
                return data
            }
            
            if let data = UserDefaults.standard.object(forKey: key) as? Data,
               let value = (try? PropertyListDecoder().decode(T.self, from: data)),
               !((value as? OptionalProtocol)?.isNil ?? false) {
                _wrappedValue = value
                return value
            }
            return defaultValue
        }
        set {
            if (newValue as? OptionalProtocol)?.isNil ?? false {
                _wrappedValue = nil
                UserDefaults.standard.removeObject(forKey: key)
            } else {
                _wrappedValue = newValue
                UserDefaults.standard.set((try? PropertyListEncoder().encode(newValue)) ?? newValue, forKey: key)
            }
        }
    }
}
