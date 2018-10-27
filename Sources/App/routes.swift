import Vapor

public func routes(_ router: Router) throws {
    let scooterController = ScooterController()
    router.get("free_bikes", use: scooterController.availableScooters)
}
