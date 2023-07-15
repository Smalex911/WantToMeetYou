//
//  UserLocation.swift
//  WantToMeetYou
//
//  Created by Александр Смородов on 25.06.2023.
//

import Foundation

class UserLocation: Codable {
    
    var coords: Coordinates
    var modDate: TimeInterval
    
    init(coords: Coordinates, modDate: TimeInterval) {
        self.coords = coords
        self.modDate = modDate
    }
}

extension UserLocation {
    
    class Coordinates: Codable {
        
        var lattitude: Double
        var longitude: Double
        
        init(lattitude: Double, longitude: Double) {
            self.lattitude = lattitude
            self.longitude = longitude
        }
    }

}
