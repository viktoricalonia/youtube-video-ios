import Foundation

class AppServices: ServicesProtocol {
  let api: any APIClientProtocol
  
  let videoAPI: any VideoListAPI
  let commentAPI: any CommentAPI

  init(config: AppConfigProtocol) {
    let api = YoutubeClient(config: config)
    
    self.api = api
    
    // network
    self.videoAPI = api
    self.commentAPI = api
  }
}
