import FluentSQLite

final class CreateScooterFleet: SQLiteMigration {
    static let scooterFleetSize = 100
    
    static func prepare(on conn: SQLiteConnection) -> EventLoopFuture<Void> {
        var fleetCreations: [EventLoopFuture<Void>] = []
        for i in 1...scooterFleetSize {
            fleetCreations.append(Scooter(id: i).create(on: conn).map { scooter in
                let randomLocation = WorldController.randomLocation()
                scooter.longitude = randomLocation.longitude
                scooter.latitude = randomLocation.latitude
                scooter.save(on: conn)
            })
        }
        
        return Future<Void>.andAll(fleetCreations, eventLoop: conn.eventLoop)
    }
    
    static func revert(on conn: SQLiteConnection) -> EventLoopFuture<Void> {
        let deleteAllScooters = Scooter.query(on: conn).delete()
        
        return Future<Void>.andAll([deleteAllScooters], eventLoop: conn.eventLoop)
    }
}
