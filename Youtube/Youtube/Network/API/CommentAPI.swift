import Foundation

protocol CommentAPI {
  func fetchComments(for videoId: String) async throws -> [Comment]

  func fetchCommentReply(for commentId: String) async throws -> [Comment]
}

extension APIClient: CommentAPI {
  public func fetchComments(for videoId: String) async throws -> [Comment] {
    return [Comment.stub]
  }
  
  public func fetchCommentReply(for commentId: String) async throws -> [Comment] {
    return [Comment.stub]
  }
}
