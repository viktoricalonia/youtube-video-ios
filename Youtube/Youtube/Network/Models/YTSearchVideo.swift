import Foundation

struct YTSeachVideoIdentifier: Decodable {
  let kind: String
  let videoId: String
}

struct YTSearchVideo: Decodable {
  let id: YTSeachVideoIdentifier
  let snippet: YTVideoSnippet
}

struct YTSearchVideoResponse: Decodable {
  let items: [YTSearchVideo]
}
