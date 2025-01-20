import Foundation

protocol AppConfigProtocol {
  var apiKey: String { get }
}

struct AppConfig: AppConfigProtocol {
  let baseURL: String = "https://www.googleapis.com/youtube/v3"
  let apiKey: String = "AIzaSyCwbGziupadfpxuaTv72BsKZxOAQQDDj9A"
}
