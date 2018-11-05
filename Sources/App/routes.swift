import Vapor

public func routes(_ router: Router) throws {
    let scooterController = ScooterController()
    router.get("free_bikes", use: scooterController.availableScooters)
    
    let rateLimitController = RateLimitController()
    router.get("set_rate_limit", use: rateLimitController.setRateLimit)
}
