import Vapor
import FluentSQLite
import Guardian

final class RateLimitController {
    static let rateLimiter = GuardianMiddleware(rate: Rate(limit: 30000, interval: .minute))
    
    func setRateLimit(_ req: Request) throws -> String {
        guard let limit = req.query[Int.self, at: "limit"] else {
            return "Bad Request"
        }
        
        RateLimitController.rateLimiter.setRate(Rate(limit: limit, interval: .minute))
        return String(format:"New Rate Limit is: %i requests per minute", limit)
    }
}
