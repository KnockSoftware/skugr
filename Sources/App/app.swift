import Vapor
import Jobs

/// Creates an instance of Application. This is called from main.swift in the run target.
public func app(_ env: Environment) throws -> Application {
    var config = Config.default()
    var env = env
    var services = Services.default()
    try configure(&config, &env, &services)
    let app = try Application(config: config, environment: env, services: services)
    try boot(app)
    
    let world = WorldController()
    Jobs.add(interval: .seconds(20)) {
        let _ = app.withNewConnection(to: .sqlite) { conn in
            world.updateWorld(conn)
        }
    }
    
    return app
}
