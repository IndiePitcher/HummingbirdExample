import Hummingbird
import HummingbirdTesting
import Logging
import XCTest

@testable import App

final class AppTests: XCTestCase {
    struct TestArguments: AppArguments {
        let hostname = "127.0.0.1"
        let port = 0
        let logLevel: Logger.Level? = .trace
    }

    func testApp() async throws {
        // FIXME: crashes on IndiePitcher API key not found precondition
        
        // let args = TestArguments()
        // let app = try await buildApplication(args)
        // try await app.test(.router) { client in
        //     try await client.execute(uri: "/", method: .get) { response in
        //         XCTAssertEqual(response.body, ByteBuffer(string: "Hello! Trigger an email by visiting /send_email endpoint!"))
        //     }
        // }
    }
}
