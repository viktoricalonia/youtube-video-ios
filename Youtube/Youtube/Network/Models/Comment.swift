import Foundation

struct Comment: Equatable, Identifiable {
  var id: String
  var text: String
  var actorName: String
  var isReply: Bool
  var parentCommentId: String?
}

extension Comment {
  static func stub(
    id: String = UUID().uuidString,
    text: String = UUID().uuidString,
    actorName: String = UUID().uuidString,
    isReply: Bool = false
  ) -> Comment {
    .init(id: id, text: text, actorName: actorName, isReply: isReply)
  }

  static var stub: Comment {
    Comment(id: "", text: "", actorName: "", isReply: false)
  }
}
