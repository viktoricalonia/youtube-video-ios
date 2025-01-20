import Foundation

struct Comment {
  var commentId: String
  var text: String
  var actorName: String
  var isReply: Bool
  var parentCommentId: String?
}

extension Comment {
  static func stub(
    commentId: String = UUID().uuidString,
    text: String = UUID().uuidString,
    actorName: String = UUID().uuidString,
    isReply: Bool = false
  ) -> Comment {
    .init(commentId: commentId, text: text, actorName: actorName, isReply: isReply)
  }

  static var stub: Comment {
    Comment(commentId: "", text: "", actorName: "", isReply: false)
  }
}
