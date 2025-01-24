import Foundation

struct YTCommentItemsMapper: DecodeSerializerProtocol {
  typealias ResponseModel = YTCommentResponse
  
  static func make(_ data: Data) throws -> YTCommentResponse {
    print(String(data: data, encoding: .utf8) ?? "")
    return try transform(data: data)
  }
}
