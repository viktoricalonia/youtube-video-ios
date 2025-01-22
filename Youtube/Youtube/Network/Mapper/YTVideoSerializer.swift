import Foundation

enum YTVideosSerializer: DecodeSerializerProtocol {
  typealias ResponseModel = YTVideoResponse

  static func make(_ data: Data) throws -> YTVideoResponse {
    return try transform(data: data)
  }
}
