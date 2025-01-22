import Foundation

protocol APIClientProtocol {
  func request<T>(
    endpoint: String,
    method: APIClient.Method,
    parameterJSON: [String: any CustomStringConvertible]?,
    serializer: @escaping (Data) throws -> T
  ) async throws -> T
}

class APIClient: APIClientProtocol {
  enum Method: String, Equatable {
    case get
    case post
    case put
  }

  let session: URLSession
  let baseUrl: String

  private(set) var sessionToken: String = ""

  deinit {
    URLSession.shared.getAllTasks { tasks in
      tasks
        .filter { $0.state == .running }
        .forEach { $0.cancel() }
    }
  }

  init(baseUrl: String) {
    session = URLSession.shared
    self.baseUrl = baseUrl
  }

  func setAuthToken(_ token: String) {
    sessionToken = token
  }

  func request<T>(
    endpoint: String,
    method: APIClient.Method,
    parameterJSON: [String: any CustomStringConvertible]?,
    serializer: @escaping (Data) throws -> T
  ) async throws -> T {
    let headers = [
      "Content-Type": "application/json",
      "Authorization": "Bearer \(sessionToken)",
    ]

    var httpBody: Data?
    var url: URL!
    if let parameters = parameterJSON {
      if [APIClient.Method.post, APIClient.Method.put].contains(where: { $0 == method }) {
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        httpBody = postData as Data

        url = URL(string: baseUrl + endpoint)
      } else {
        var urlComps = URLComponents(string: baseUrl + endpoint)
        var queryItems: [URLQueryItem] = []
        for (key, value) in parameters {
          queryItems.append(URLQueryItem(name: key, value: value.description))
        }
        urlComps?.queryItems = queryItems
        url = urlComps?.url
      }
    }

    let request = NSMutableURLRequest(
      url: url,
      cachePolicy: .useProtocolCachePolicy,
      timeoutInterval: 10.0)
    request.httpMethod = method.rawValue.uppercased()
    request.allHTTPHeaderFields = headers
    request.httpBody = httpBody
    print(request.url!)

    let (data, _) = try await session.data(from: url)
    print(String(data: data, encoding: .utf8)!)
    return try serializer(data)
  }
}

extension Data {
  var prettyPrintedJSONString: NSString? {
    guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
          let data = try? JSONSerialization.data(withJSONObject: jsonObject,
                                                 options: [.prettyPrinted]),
          let prettyJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
      return nil
    }

    return prettyJSON
  }
}
