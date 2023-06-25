//
//  Ext+Codable.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 25.06.2023.
//

import Foundation

extension Encodable {

    var json: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
        return json
    }
}
