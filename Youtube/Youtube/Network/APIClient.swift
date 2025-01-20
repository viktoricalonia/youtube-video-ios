import Foundation

protocol APIClientProtocol {
  @discardableResult
  func request<T>(
    endpoint: String,
    method: APIClient.Method,
    parameterJSON: [String: Any]?,
    serializer: @escaping (Data) throws -> T,
    result: @escaping (Result<T, ResponseError>) -> Void) -> Pausable

  @discardableResult
  func request<T>(
    endpoint: String,
    method: APIClient.Method,
    arrayParameterJSON: [[String: Any]]?,
    serializer: @escaping (Data) throws -> T,
    result: @escaping (Result<T, ResponseError>) -> Void) -> Pausable

  @discardableResult
  func uploadPutRequest<T>(
    endpoint: String,
    fileData: Data,
    parameters: [String: Any]?,
    progressBlock: SingleResult<Progress>?,
    serializer: @escaping (Data) throws -> T,
    result: @escaping (Result<T, ResponseError>) -> Void) -> Pausable
}

class APIClient: APIClientProtocol {
  var progressObservers: [NSKeyValueObservation] = []

  enum Method: String {
    case get
    case post
    case put
  }

  let session: URLSession
  let baseUrl: String

  private(set) var sessionToken: String = ""

  deinit {
    progressObservers.forEach { observation in
      observation.invalidate()
    }
  }

  init(baseUrl: String) {
    session = URLSession.shared
    self.baseUrl = baseUrl
  }

  func setAuthToken(_ token: String) {
    sessionToken = token
  }

  @discardableResult
  func request<T>(
    endpoint: String,
    method: APIClient.Method,
    parameterJSON: [String: Any]?,
    serializer: @escaping (Data) throws -> T,
    result: @escaping (Result<T, ResponseError>) -> Void) -> Pausable {
    var headers = [
      "Content-Type": "application/json",
    ]

    if !sessionToken.isEmpty {
      headers["Authorization"] = "Bearer \(sessionToken)"
    }

    let request = NSMutableURLRequest(
      url: NSURL(string: baseUrl + endpoint)! as URL,
      cachePolicy: .useProtocolCachePolicy,
      timeoutInterval: 10.0)
    request.httpMethod = method.rawValue.uppercased()
    request.allHTTPHeaderFields = headers

    if let parameters = parameterJSON {
      let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
      request.httpBody = postData as Data
    }

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
      if let response = response as? HTTPURLResponse {
        if let error = error {
          result(.failure(ResponseMapper.handleResponseError(response: response, error: error)))
        } else if let data = data {
          result(ResponseMapper.resultFrom(response: response, data: data, serializer: serializer))
        } else {
          result(.failure(ResponseError.unhandledResponse))
        }
      } else {
        result(.failure(ResponseError.noResponse))
      }
    })
    dataTask.resume()
    return dataTask
  }

  @discardableResult
  func request<T>(
    endpoint: String,
    method: APIClient.Method,
    arrayParameterJSON: [[String: Any]]?,
    serializer: @escaping (Data) throws -> T,
    result: @escaping (Result<T, ResponseError>) -> Void) -> Pausable {
    var headers = [
      "Content-Type": "application/json",
    ]

    if !sessionToken.isEmpty {
      headers["Authorization"] = "Bearer \(sessionToken)"
    }

    let request = NSMutableURLRequest(
      url: NSURL(string: baseUrl + endpoint)! as URL,
      cachePolicy: .useProtocolCachePolicy,
      timeoutInterval: 10.0)
    request.httpMethod = method.rawValue.uppercased()
    request.allHTTPHeaderFields = headers

    if let parameters = arrayParameterJSON {
      let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
      request.httpBody = postData as Data
    }

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
      if let response = response as? HTTPURLResponse {
        if let error = error {
          result(.failure(ResponseMapper.handleResponseError(response: response, error: error)))
        } else if let data = data {
          result(ResponseMapper.resultFrom(response: response, data: data, serializer: serializer))
        } else {
          result(.failure(ResponseError.unhandledResponse))
        }
      } else {
        result(.failure(ResponseError.noResponse))
      }
    })
    dataTask.resume()
    return dataTask
  }

  @discardableResult
  func uploadPutRequest<T>(
    endpoint: String,
    fileData: Data,
    parameters: [String: Any]?,
    progressBlock: SingleResult<Progress>?,
    serializer: @escaping (Data) throws -> T,
    result: @escaping (Result<T, ResponseError>) -> Void) -> Pausable {
    guard let url = URL(string: baseUrl + endpoint)
    else {
      result(.failure(ResponseError.invalidURL))
      return DefaultPausable()
    }

    var request = URLRequest(
      url: url,
      cachePolicy: .useProtocolCachePolicy,
      timeoutInterval: Double.infinity)
    request.httpMethod = APIClient.Method.put.rawValue.uppercased()

    var parameters = parameters ?? [:]

    parameters["key"] = "file"
    parameters["type"] = "file"

    var formData = Data()

    let uuid = UUID().uuidString
    let boundary = "Boundary-\(uuid)"

    formData.append("--\(boundary)\r\n")
    formData.append("Content-Disposition:form-data; name=file")

    for key in parameters.keys {
      if let value = parameters[key] as? String {
        formData.append("; \(key)=\(value)")
      }
    }
    formData.append("\r\n")

    formData.append("Content-Type:image/jpg\r\n")
    formData.append("\r\n")
    formData.append(fileData)
    formData.append("\r\n")
    formData.append("--\(boundary)--\r\n")

    request.httpBody = formData

    var headers = [
      "Content-Type": "multipart/form-data; boundary=\(boundary)",
    ]
    if !sessionToken.isEmpty {
      headers["Authorization"] = "Bearer \(sessionToken)"
    }
    request.allHTTPHeaderFields = headers

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request, completionHandler: { data, response, error in
      if let response = response as? HTTPURLResponse {
        if let error = error {
          result(.failure(ResponseMapper.handleResponseError(response: response, error: error)))
        } else if let data = data {
          result(ResponseMapper.resultFrom(response: response, data: data, serializer: serializer))
        } else {
          result(.failure(ResponseError.unhandledResponse))
        }
      } else {
        result(.failure(ResponseError.noResponse))
      }
    })

    let observation = dataTask.progress.observe(\.fractionCompleted) { progress, _ in
      progressBlock?(progress)
    }
    progressObservers.append(observation)

    dataTask.resume()
    return dataTask
  }
}

class DefaultPausable: Pausable {
  func resume() { }
  func suspend() { }
  func cancel() { }
}

protocol Pausable: AnyObject {
  func resume()
  func suspend()
  func cancel()
}

extension URLSessionDataTask: Pausable {}

class ResponseMapper {
  static func resultFrom<T>(response: HTTPURLResponse, data: Data, serializer: (Data) throws -> T) -> Result<T, ResponseError> {
    do {
      let resultValue = try serializer(data)
      return Result<T, ResponseError>.success(resultValue)
    } catch let error {
      debugPrint(error)
      let parseError = ResponseError.couldNotParse
      return Result<T, ResponseError>.failure(parseError)
    }
  }

  static func handleResponseError(response: HTTPURLResponse, error: Error) -> ResponseError {
    let statusCode = response.statusCode
    if let code = ResponseError.Code(rawValue: statusCode) {
      return ResponseError.networkStatus(code)
    }
    if statusCode >= 500 || statusCode < 600 {
      return ResponseError.serverRelated
    }
    return ResponseError.unknown(statusCode, error.localizedDescription)
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
