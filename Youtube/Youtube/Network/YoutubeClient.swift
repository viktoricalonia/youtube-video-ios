import Foundation

class YoutubeClient: APIClient {
  @discardableResult
  func get<T>(
    endPoint: String,
    params: [String: Any]?,
    serializer: @escaping (Data) throws -> T,
    completion: @escaping SingleResult<Result<T, Error>>
  ) -> Pausable {
    request(
      endpoint: endPoint,
      method: .get,
      parameterJSON: params,
      serializer: serializer,
      result: { result in
        switch result {
        case .success(let response):
          completion(.success(response))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    )
  }

  @discardableResult
  func post<T>(
    endPoint: String,
    params: [[String: Any]],
    serializer: @escaping (Data) throws -> T,
    completion: @escaping SingleResult<Result<T, Error>>
  ) -> Pausable {
    request(
      endpoint: endPoint,
      method: .post,
      arrayParameterJSON: params,
      serializer: serializer,
      result: { result in
        switch result {
        case .success(let response):
          completion(.success(response))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    )
  }
}
