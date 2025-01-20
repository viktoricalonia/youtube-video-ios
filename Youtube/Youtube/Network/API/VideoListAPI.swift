import Foundation

protocol VideoListAPI {
  func getVideoList() async throws -> [Video]

  func searckVideoList(query: String) async throws -> [Video]
}


extension APIClient {
  func getVideoList() async throws -> [Video] {
    return [Video.stub]
  }

  func searckVideoList(query: String) async throws -> [Video] {
    return [Video.stub]
  }
}
