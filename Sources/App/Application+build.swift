import Hummingbird
import IndiePitcherSwift
import Logging

/// Application arguments protocol. We use a protocol so we can call
/// `buildApplication` inside Tests as well as in the App executable.
/// Any variables added here also have to be added to `App` in App.swift and
/// `TestArguments` in AppTest.swift
public protocol AppArguments {
    var hostname: String { get }
    var port: Int { get }
    var logLevel: Logger.Level? { get }
}

// Request context used by application
typealias AppRequestContext = BasicRequestContext

///  Build application
/// - Parameter arguments: application arguments
public func buildApplication(_ arguments: some AppArguments) async throws
    -> some ApplicationProtocol
{
    let environment = try await Environment().merging(with: .dotEnv())

    let logger = {
        var logger = Logger(label: "HummingbirdExample")
        logger.logLevel =
            arguments.logLevel ?? environment.get("LOG_LEVEL").flatMap {
                Logger.Level(rawValue: $0)
            } ?? .info
        return logger
    }()

    guard let apiKey = environment.get("INDIEPITCHER_SECRET_KEY") else {
        preconditionFailure("Requires \"INDIEPITCHER_SECRET_KEY\" environment variable")
    }

    let indiePitcher = IndiePitcher(apiKey: apiKey)

    let router = buildRouter(indiePitcher: indiePitcher)
    let app = Application(
        router: router,
        configuration: .init(
            address: .hostname(arguments.hostname, port: arguments.port),
            serverName: "HummingbirdExample"
        ),
        logger: logger
    )
    return app
}

/// Build router
func buildRouter(indiePitcher: IndiePitcher) -> Router<AppRequestContext> {
    let router = Router(context: AppRequestContext.self)
    // Add middleware
    router.addMiddleware {
        // logging middleware
        LogRequestsMiddleware(.info)
    }

    // Add default endpoint
    router.get("/") { _, _ in
        return "Hello! Trigger an email by visiting /send_email endpoint!"
    }

    router.get("/send_email") { _, context in

        let emailBody = """
            This is an email sent from a **hummingbird 2 backend**!
            """

        try await indiePitcher.sendEmail(
            data: .init(
                to: "petr@indiepitcher.com",
                subject: "This is an email sent from a hummingbird 2 backend", body: emailBody,
                bodyFormat: .markdown))

        return "Sent!"
    }

    return router
}
