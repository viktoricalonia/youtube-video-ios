import Testing

@testable import Youtube

struct YTIntegrationTest {
  @Test func getVideos() async throws {
    let api: VideoListAPI = YoutubeClient(config: AppConfig())

    let videos = try await api.getVideoList()

    #expect(!videos.isEmpty)
  }

  @Test func getSeachVideos() async throws {
    let api: VideoListAPI = YoutubeClient(config: AppConfig())

    let videos = try await api.getSearchVideoList(query: "swift")

    #expect(!videos.isEmpty)
  }
}
