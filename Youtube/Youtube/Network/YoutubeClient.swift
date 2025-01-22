import Foundation

class YoutubeClient: APIClient {
  let apiKey: String
  
  init(config: AppConfigProtocol) {
    apiKey = config.apiKey
    super.init(baseUrl: config.baseURL)
  }
  
  func get<T>(
    endPoint: String,
    params: [String: any CustomStringConvertible]?,
    serializer: @escaping (Data) throws -> T
  ) async throws -> T {
    var finalParam = params ?? [:]
    finalParam["key"] = apiKey
    
    return try await request(
      endpoint: endPoint,
      method: .get,
      parameterJSON: finalParam,
      serializer: serializer
    )
  }
}
