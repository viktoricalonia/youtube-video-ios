import Foundation

struct Video: Equatable, Identifiable {
  var id: String
  var videoUrlString: String
  var title: String
  var thumbnailUrlString: String
}

extension Video {
  static func stub(
    id: String = UUID().uuidString,
    videoUrlString: String = UUID().uuidString,
    title: String = UUID().uuidString,
    thumbnailUrlString: String = UUID().uuidString
  ) -> Video {
    .init(
      id: id,
      videoUrlString: videoUrlString,
      title: title,
      thumbnailUrlString: thumbnailUrlString)
  }

  static var stub: Video {
    Video(id: "", videoUrlString: "", title: "", thumbnailUrlString: "")
  }
}
