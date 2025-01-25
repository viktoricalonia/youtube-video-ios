import Foundation

protocol VideoListAPI {
  func getVideoList() async throws -> [Video]

  func getSearchVideoList(query: String) async throws -> [Video]
}

extension YoutubeClient: VideoListAPI {
  func getVideoList() async throws -> [Video] {
    let params = [
      "part": "snippet",
      "fields": "items(id, snippet(title, thumbnails, publishedAt))",
      "chart": "mostPopular",
    ]

    let response = try await get(
      endPoint: "/videos",
      params: params,
      serializer: YTVideosSerializer.make
    )

    return response.items.compactMap {
      Video(
        id: $0.id,
        title: $0.snippet.title,
        thumbnailUrlString: $0.snippet.thumbnails.high.url
      )
    }
  }

  func getSearchVideoList(query: String) async throws -> [Video] {
    let params = [
      "q": query,
      "part": "snippet",
      "fields": "items(id, snippet(title, thumbnails, publishedAt))",
      "type": "video"
    ]

    let response = try await get(
      endPoint: "/search",
      params: params,
      serializer: YTSearchVideosSerializer.make
    )

    return response.items.compactMap {
      Video(
        id: $0.id.videoId,
        title: $0.snippet.title,
        thumbnailUrlString: $0.snippet.thumbnails.high.url
      )
    }
  }
}
