import Foundation

struct Comment: Hashable, Identifiable {
  var id: String
  var text: String
  var actorName: String
  var publishedDateText: String
}

extension Comment {
  static func stub(
    id: String = UUID().uuidString,
    text: String = UUID().uuidString,
    actorName: String = UUID().uuidString,
    publishedDateText: String = UUID().uuidString
  ) -> Comment {
    .init(id: id, text: text, actorName: actorName, publishedDateText: publishedDateText)
  }

  static var stub: Comment {
    Comment(id: "", text: "", actorName: "", publishedDateText: "")
  }
}
