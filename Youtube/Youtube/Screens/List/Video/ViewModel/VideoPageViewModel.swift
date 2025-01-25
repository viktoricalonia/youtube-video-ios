 import Foundation
import UIKit

protocol VideoPageProtocol {
  var video: Video { get }
  
  func getComments() async throws -> [Comment]
  func getNextComments() async throws -> [Comment]
}

final class VideoPageViewModel: VideoPageProtocol {
  let video: Video
  let api: CommentAPI
  
  private var nextPageToken: String? = nil
  
  init(video: Video, api: CommentAPI) {
    self.video = video
    self.api = api
  }

  func getComments() async throws -> [Comment] {
    let response = try await api.getComments(videoId: video.id, pageToken: nextPageToken)
    return response.items.map {
      Comment(
        id: $0.id,
        text: $0.snippet.topLevelComment.snippet.textOriginal,
        actorName: $0.snippet.topLevelComment.snippet.authorDisplayName,
        imageURLString: $0.snippet.topLevelComment.snippet.authorProfileImageUrl,
        publishedDateText: $0.snippet.topLevelComment.snippet.publishedAt.fromISO86601NoMSDateStringToDate()?.relativeDateString ?? "")
    }
  }
  
  func getNextComments() async throws -> [Comment] {
    let response = try await api.getComments(videoId: video.id, pageToken: nextPageToken)
    nextPageToken = response.nextPageToken
    return response.items.map {
      Comment(
        id: $0.id,
        text: $0.snippet.topLevelComment.snippet.textOriginal,
        actorName: $0.snippet.topLevelComment.snippet.authorDisplayName,
        imageURLString: $0.snippet.topLevelComment.snippet.authorProfileImageUrl,
        publishedDateText: $0.snippet.topLevelComment.snippet.publishedAt.fromISO86601NoMSDateStringToDate()?.relativeDateString ?? "")
    }
  }
}
