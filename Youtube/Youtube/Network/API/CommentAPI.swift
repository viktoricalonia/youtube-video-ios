import Foundation

protocol CommentAPI {
  func getComments(
    videoId: String
  ) async throws -> YTCommentResponse
  
  func getComments(
    videoId: String,
    pageToken: String?
  ) async throws -> YTCommentResponse
}

extension YoutubeClient: CommentAPI {
  func getComments(
    videoId: String
  ) async throws -> YTCommentResponse {
    try await getComments(
      videoId: videoId,
      pageToken: nil
    )
  }
  
  func getComments(
    videoId: String,
    pageToken: String? = nil
  ) async throws -> YTCommentResponse {
    var params = [
      "videoId": videoId,
      "part": "snippet",
      "fields": "nextPageToken, pageInfo, items(id, snippet(topLevelComment(snippet(textDisplay, textOriginal, authorDisplayName, authorProfileImageUrl, publishedAt))))",
      "prettyPrint": "true"
    ]
    if let pageToken = pageToken {
      params["pageToken"] = pageToken
    }

    return try await get(
      endPoint: "/commentThreads",
      params: params,
      serializer: YTCommentItemsMapper.make
    )
  }
}
