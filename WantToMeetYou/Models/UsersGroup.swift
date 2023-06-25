//
//  UsersGroup.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 25.06.2023.
//

import Foundation

class UsersGroup: Codable {
    
    private(set) var uuid: String = UUID().uuidString
    
    var name: String
    var usersUID: [String: Role]
    
    init(name: String, usersUID: [String: Role]) {
        self.name = name
        self.usersUID = usersUID
    }
}

extension UsersGroup {
    
    enum Role: String, Codable {
        case admin
        case user
    }
}
