import Foundation

protocol AppConfigProtocol {
  var baseURL: String { get }
  var apiKey: String { get }
}

struct AppConfig: AppConfigProtocol {
  let baseURL: String = "https://www.googleapis.com/youtube/v3"
  let apiKey: String = "AIzaSyDdWAyNL_zGAEF90Hez5S2028J2ZVuTVAI"
}
