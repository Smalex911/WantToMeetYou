//
//  Ext+DataSnapshot.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 16.07.2023.
//

import Foundation
import FirebaseDatabase

extension DataSnapshot {
    
    func serializeValue<T: Codable>() -> T? {
        let value = value as? [String: Any]
        return try? value?.serialize()
    }
}
