import FluentSQLite
import Vapor

/// A single entry of a Scooter list.
final class Scooter: SQLiteModel {
    var id: Int?
    var uid: String

    var longitude: Float
    var latitude: Float
    
    var reserved: Bool
    var disabled: Bool

    /// Creates a new `Scooter`.
    init(id: Int) {
        self.uid = UUID().uuidString
        self.id = id
        self.reserved = false
        self.disabled = false
        
        self.longitude = -1
        self.latitude = -1
    }
}

/// Allows `Scooter` to be used as a dynamic migration.
extension Scooter: Migration { }

/// Allows `Scooter` to be encoded to and decoded from HTTP messages.
extension Scooter: Content { }

/// Allows `Scooter` to be used as a dynamic parameter in route definitions.
extension Scooter: Parameter { }