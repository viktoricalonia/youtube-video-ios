import Foundation

struct YTURLObject: Decodable {
  let url: String
}

struct YTThumbnail: Decodable {
  let standard: YTURLObject?
  let maxres: YTURLObject?
  let high: YTURLObject
}

struct YTVideoSnippet: Decodable {
  let thumbnails: YTThumbnail
  let title: String
  let publishedAt: String
}

struct YTVideo: Decodable {
  let id: String
  let snippet: YTVideoSnippet
}

struct YTVideoResponse: Decodable {
  let items: [YTVideo]
}
