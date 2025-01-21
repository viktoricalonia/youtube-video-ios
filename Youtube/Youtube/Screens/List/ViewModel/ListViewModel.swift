import Foundation

protocol ListViewModel {
  var items: [Video] { get }

  @discardableResult
  func fetchItems() async throws -> [Video]

  @discardableResult
  func searchItems(query: String) async throws -> [Video]
}

class YoutubeVidListViewModel: ListViewModel {

  let api: VideoListAPI

  var items: [Video] = []

  init(api: VideoListAPI) {
    self.api = api
  }

  @discardableResult
  func fetchItems() async throws -> [Video] {
    items = try await api.getVideoList()
    return items
  }

  @discardableResult
  func searchItems(query: String) async throws -> [Video] {
    items = try await api.searckVideoList(query: query)
    return items
  }
}

extension YoutubeVidListViewModel {
  enum State: Equatable {
    case loading
    case error
    case content(items: [Video])
  }
}
