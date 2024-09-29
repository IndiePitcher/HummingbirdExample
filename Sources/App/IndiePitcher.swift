import Hummingbird
import IndiePitcherSwift

extension BasicRequestContext {
    var indiePitcher: IndiePitcher {
        get async {

            var apiKey: String?
            apiKey = Environment().get("INDIEPITCHER_SECRET_KEY")

            if apiKey == nil {
                apiKey = try? await Environment.dotEnv().get("INDIEPITCHER_SECRET_KEY")
            }

            guard let apiKey else {
                preconditionFailure("Requires \"INDIEPITCHER_SECRET_KEY\" environment variable")
            }

            return IndiePitcher(client: .shared, apiKey: apiKey)
        }
    }
}
