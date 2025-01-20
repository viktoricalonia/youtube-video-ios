import Foundation

enum ResponseError: Error, Equatable {
  case conflict
  case couldNotParse
  case invalidURL
  case networkStatus(Code)
  case noResponse
  case unhandledResponse
  case serverRelated
  case unknown(Int, String)

  public enum Code: Int {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case noInternet = 900
  }

  public var description: String {
    switch self {
    case let .networkStatus(code):
      return String("Network response: \(code.rawValue)")
    case .couldNotParse:
      return "Could not parse"
    case .noResponse:
      return "No response"
    case .unhandledResponse:
      return "Unhandled response"
    case .invalidURL:
      return "Invalid URL"
    case .conflict:
      return "Conflict"
    case .serverRelated:
      return "Server Related Error"
    case let .unknown(code, description):
      return "Unknown error: \(code), \(description)"
    }
  }
}
