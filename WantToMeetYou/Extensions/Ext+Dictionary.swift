//
//  Ext+Dictionary.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 25.06.2023.
//

import Foundation

extension Dictionary {
    
    func serialize<T: Decodable>() throws -> T {
        let json = try JSONSerialization.data(withJSONObject: self)
        return try JSONDecoder().decode(T.self, from: json)
    }
}
