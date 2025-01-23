import Foundation

struct Video: Hashable, Identifiable {
  var id: String
  var title: String
  var thumbnailUrlString: String

  var videoEmbedUrlString: String {
    "https://www.youtube.com/embed/\(id)"
  }
}

extension Video {
  static func stub(
    id: String = UUID().uuidString,
    title: String = UUID().uuidString,
    thumbnailUrlString: String = UUID().uuidString
  ) -> Video {
    .init(
      id: id,
      title: title,
      thumbnailUrlString: thumbnailUrlString)
  }

  static var stub: Video {
    Video(id: "", title: "", thumbnailUrlString: "")
  }
}
