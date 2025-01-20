import Foundation

class AppServices: ServicesProtocol {
  var api: any APIClientProtocol

  init(config: AppConfigProtocol) {
    api = APIClient(baseUrl: "")
  }
}
