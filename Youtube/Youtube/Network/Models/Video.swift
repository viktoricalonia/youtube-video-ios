import Foundation

struct Video {
  var videoId: String
  var videoUrlString: String
  var title: String
  var thumbnailUrlString: String
}

extension Video {
  static func stub(
    videoId: String = UUID().uuidString,
    videoUrlString: String = UUID().uuidString,
    title: String = UUID().uuidString,
    thumbnailUrlString: String = UUID().uuidString
  ) -> Video {
    .init(videoId: videoId, videoUrlString: videoUrlString, title: title, thumbnailUrlString: thumbnailUrlString)
  }

  static var stub: Video {
    Video(videoId: "", videoUrlString: "", title: "", thumbnailUrlString: "")
  }
}
