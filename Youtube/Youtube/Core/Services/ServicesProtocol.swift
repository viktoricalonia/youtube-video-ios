import Foundation

protocol ServicesProtocol: AnyObject {
  var api: APIClientProtocol { get }
  
  var videoAPI: VideoListAPI { get }
  var commentAPI: CommentAPI { get }
}
