//
//  WorldController.swift
//  App
//
//  Created by William Henderson on 10/27/18.
//

import Foundation
import FluentSQLite

final class WorldController {
    static func randomLocation()->(latitude: Float, longitude: Float) {
        return (Float.random(in: 420000...430000)/10000, Float.random(in: 420000...430000)/10000)
    }
    
    func updateWorld(_ conn: SQLiteConnection)->EventLoopFuture<Void> {
        print("🌍 Updating world")
        
        return Scooter.query(on: conn).filter(\Scooter.reserved == false).all().map { freeScooters in
            for _ in 0...freeScooters.count/20 {
                // start a trip for a 20th of the unreserved fleet
                if let scoot = freeScooters.random {
                    scoot.reserved = true
                    scoot.save(on: conn)
                }
            }
            }.then {
                Scooter.query(on: conn).filter(\Scooter.reserved == true).all().map { reservedScooters in
                    for _ in 0...reservedScooters.count/20 {
                        // end a trip for a 20th of the unreserved fleet
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
