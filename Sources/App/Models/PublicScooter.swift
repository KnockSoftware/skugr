//
//  PublicScooter.swift
//  App
//
//  Created by William Henderson on 10/27/18.
//

import Foundation

final class PublicScooter: Codable {
    var uid: String
    var longitude: Float
    var latitude: Float
    var reserved: Bool
    var disabled: Bool
    
    private enum CodingKeys: String, CodingKey {
        case reserved = "is_reserved"
        case disabled = "is_disabled"
        case latitude = "lat"
        case longitude = "lon"
        case uid = "bike_id"
    }
    
    init(scooter: Scooter) {
        self.uid = String(scooter.uid.suffix(6)) // only render the last 6 digits. This could cause collisions. Exciting!
        self.reserved = scooter.reserved
        self.disabled = scooter.disabled
        
        self.longitude = scooter.longitude
        self.latitude = scooter.latitude
    }
}
