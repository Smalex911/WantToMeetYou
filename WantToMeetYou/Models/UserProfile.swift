//
//  UserProfile.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 25.06.2023.
//

import Foundation

class UserProfile: Codable {
    
    private(set) var uid: String
    
    var name: String?
    var groups: [String: Group]?
    
    init(uid: String) {
        self.uid = uid
    }
}

extension UserProfile {
    
    class Group: Codable {
        
        var name: String
        
        init(name: String) {
            self.name = name
        }
    }
}
