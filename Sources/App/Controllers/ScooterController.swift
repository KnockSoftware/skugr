import Vapor
import FluentSQLite

/// Controls basic CRUD operations on `Scooter`s.
final class ScooterController {
    struct AvailableScootersResponseData: Codable {
        var bikes: [PublicScooter]
    }
    struct AvailableScootersResponse: Codable {
        var ttl: Int
        var last_updated: Int
        var data : AvailableScootersResponseData
    }
    
    /// Returns a list of all `Scooter`s.
    func availableScooters(_ req: Request) throws -> Future<String> {
        return Scooter.query(on: req).filter(\Scooter.reserved == false).all().map() { scooters in
            let response = AvailableScootersResponse(ttl: 0, last_updated: Int(Date().timeIntervalSinceReferenceDate), data: AvailableScootersResponseData(bikes: scooters.map({$0.public})))
            
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(response)
                return String(data: jsonData, encoding: .utf8) ?? "FAIL"
            } catch {
                return "FAIL"
            }
        }
    }
}
