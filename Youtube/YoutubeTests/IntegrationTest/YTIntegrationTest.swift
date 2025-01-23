import Testing

@testable import Youtube

struct YTIntegrationTest {
  let client = YoutubeClient(config: AppConfig())
  
  @Test func getVideos() async throws {
    let api: VideoListAPI = client

    let videos = try await api.getVideoList()

    #expect(!videos.isEmpty)
  }

  @Test func getSeachVideos() async throws {
    let api: VideoListAPI = client

    let videos = try await api.getSearchVideoList(query: "swift")

    #expect(!videos.isEmpty)
  }
}
