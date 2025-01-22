import Foundation

enum YTSearchVideosSerializer: DecodeSerializerProtocol {
  typealias ResponseModel = YTSearchVideoResponse

  static func make(_ data: Data) throws -> YTSearchVideoResponse {
    return try transform(data: data)
  }
}


