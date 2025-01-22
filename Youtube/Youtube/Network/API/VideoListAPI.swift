import Foundation

protocol VideoListAPI {
  func getVideoList() async throws -> [Video]

  func searchVideoList(query: String) async throws -> [Video]
}

extension YoutubeClient: VideoListAPI {
  func getVideoList() async throws -> [Video] {
    let params = [
      "part": "snippet",
      "fields": "items(id, snippet(title, thumbnails))",
      "chart": "mostPopular",
      "regionCode": "US",
    ]

    let videos = try await get(
      endPoint: "/videos",
      params: params,
      serializer: YTVideosSerializer.make)

    return videos.compactMap {
      Video(
        id: $0.id,
        title: $0.snippet.title,
        thumbnailUrlString: $0.snippet.thumbnails.high.url
      )
    }
  }

  func searchVideoList(query: String) async throws -> [Video] {
    let params = [
      "part": "snippet,",
      "fields": "items(id,snippet(title,thumbnails))",
    ]

    let videos = try await get(
      endPoint: "/search",
      params: params,
      serializer: YTVideosSerializer.make)

    return videos.compactMap {
      Video(
        id: $0.id,
        title: $0.snippet.title,
        thumbnailUrlString: $0.snippet.thumbnails.high.url
      )
    }
  }
}
