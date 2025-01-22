import Foundation

class YoutubeClient: APIClient {
  let apiKey: String

  init(config: AppConfigProtocol) {
    self.apiKey = config.apiKey
    super.init(baseUrl: config.baseURL)
  }

  func get<T>(
    endPoint: String,
    params: [String: any CustomStringConvertible]?,
    serializer: @escaping (Data) throws -> T
  ) async throws -> T {
    try await request(
      endpoint: endPoint + "?key=\(apiKey)",
      method: .get,
      parameterJSON: params,
      serializer: serializer)
  }

  func post<T>(
    endPoint: String,
    params: [String: any CustomStringConvertible],
    serializer: @escaping (Data) throws -> T
  ) async throws -> T {
    try await request(
      endpoint: endPoint + "key=\(apiKey)",
      method: .post,
      parameterJSON: params,
      serializer: serializer)
  }
}
