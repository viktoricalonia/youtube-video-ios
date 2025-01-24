import Foundation

struct YTCommentItemTopLevelSnippet: Decodable {
  let textDisplay: String
  let textOriginal: String
  let authorDisplayName: String
  let authorProfileImageUrl: String
  let publishedAt: String
}

struct YTCommentItemTopLevelComment: Decodable {
  let snippet: YTCommentItemTopLevelSnippet
}

struct YTCommentItemSnippet: Decodable {
  let topLevelComment: YTCommentItemTopLevelComment
}

struct YTCommentItem: Decodable {
  let id: String
  let snippet: YTCommentItemSnippet

}

struct YTCommentResponsePageInfo: Decodable {
  let totalResults: Int
  let resultsPerPage: Int
}

struct YTCommentResponse: Decodable {
  let nextPageToken: String
  let pageInfo: YTCommentResponsePageInfo
  let items: [YTCommentItem]
}
