import Foundation

class AppServices: ServicesProtocol {
  let api: any APIClientProtocol
  
  let videoAPI: any VideoListAPI

  init(config: AppConfigProtocol) {
    let api = YoutubeClient(config: config)
    
    self.api = api
    self.videoAPI = api
  }
}
