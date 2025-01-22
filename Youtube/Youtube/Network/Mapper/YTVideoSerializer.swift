import Foundation

enum YTVideosSerializer: DecodeSerializerProtocol {
  typealias ResponseModel = [YTVideo]

  static func make(_ data: Data) throws -> [YTVideo] {
    return try transform(data: data)
  }
}
