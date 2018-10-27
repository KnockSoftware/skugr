import Vapor
import FluentSQLite

/// Controls basic CRUD operations on `Scooter`s.
final class ScooterController {
    /// Returns a list of all `Scooter`s.
    func availableScooters(_ req: Request) throws -> Future<[Scooter]> {
        return Scooter.query(on: req).filter(\Scooter.reserved == false).all()
    }
}
