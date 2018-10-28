//
//  WorldController.swift
//  App
//
//  Created by William Henderson on 10/27/18.
//

import Foundation
import FluentSQLite
import GeoSwift

final class WorldController {
    static let portlandCoord = try! GeoCoordinate2D(latitude: 45.5122, longitude: -122.6587)
    
    static func randomLocation()->GeoCoordinate2D {
        let distanceScale:Double = 100 // crappy way to do this
        let latOffset = Double.random(in: 0..<1)/distanceScale
        let longOffset = Double.random(in: 0..<1)/distanceScale
        
        return try! GeoCoordinate2D(latitude: WorldController.portlandCoord.latitude + latOffset, longitude: WorldController.portlandCoord.longitude + longOffset)
    }
    
    func updateWorld(_ conn: SQLiteConnection)->EventLoopFuture<Void> {
        print("🌍 Updating world")
        
        return Scooter.query(on: conn).filter(\Scooter.reserved == false).all().map { freeScooters in
            for _ in 0...freeScooters.count/50 {
                // start a trip for a 20th of the unreserved fleet
                if let scoot = freeScooters.random {
                    scoot.reserved = true
                    scoot.save(on: conn)
                }
            }
            }.then {
                Scooter.query(on: conn).filter(\Scooter.reserved == true).all().map { reservedScooters in
                    for _ in 0...reservedScooters.count/5 {
                        // end a trip for a 5th of the unreserved fleet
                        if let scoot = reservedScooters.random {
                            scoot.reserved = false
                            let randomLocation = WorldController.randomLocation()
                            scoot.latitude = randomLocation.latitude
                            scoot.longitude = randomLocation.longitude
                            scoot.save(on: conn)
                        }
                    }
                }
        }
    }
}
