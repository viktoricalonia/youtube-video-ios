import Testing

@testable import Youtube

struct YTIntegrationTest {
  let client = YoutubeClient(config: AppConfig())
  
  @Test func canGetVideos() async throws {
    let api: VideoListAPI = client

    let videos = try await api.getVideoList()

    #expect(!videos.isEmpty)
  }

  @Test func canGetSeachVideos() async throws {
    let api: VideoListAPI = client

    let videos = try await api.getSearchVideoList(query: "swift")

    #expect(!videos.isEmpty)
  }
  
  @Test func canGetComments() async throws {
    let api: CommentAPI = client
    let videoId = "_VB39Jo8mAQ"

    let response = try await api.getComments(videoId: videoId)
    
    #expect(!response.items.isEmpty)
  }

  @Test func canGetNextComments() async throws {
    let api: CommentAPI = client
    let videoId = "_VB39Jo8mAQ"

    let response = try await api.getComments(videoId: videoId)
    
    let nextPageToken = response.nextPageToken
    let nextPageResponse = try await api.getComments(videoId: videoId, pageToken: nextPageToken)
    
    #expect(!response.items.isEmpty)
    #expect(!nextPageResponse.items.isEmpty)
  }
}
