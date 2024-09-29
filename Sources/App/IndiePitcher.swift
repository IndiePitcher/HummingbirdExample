import Hummingbird
import IndiePitcherSwift

extension BasicRequestContext {
    var indiePitcher: IndiePitcher {
        get async {

            let env = try? await Environment.dotEnv()
            guard let apiKey = env?.get("INDIEPITCHER_SECRET_KEY") else {
                preconditionFailure("Requires \"INDIEPITCHER_SECRET_KEY\" environment variable")
            }

            return IndiePitcher(client: .shared, apiKey: apiKey)
        }
    }
}
