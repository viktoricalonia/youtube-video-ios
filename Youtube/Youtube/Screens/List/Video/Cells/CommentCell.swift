import Foundation
import UIKit

import SDWebImage

final class CommentCell: UITableViewCell {
  @IBOutlet private var commentLabel: UILabel!
  @IBOutlet private var actorName: UILabel!
  @IBOutlet private var actorImageView: UIImageView!
  @IBOutlet private var timeLabel: UILabel!
  
  var comment: Comment? {
    didSet {
      guard let comment = comment else { return }
      
      commentLabel.text = comment.text
      actorImageView.sd_setImage(with: URL(string: comment.imageURLString))
      actorName.text = comment.actorName
      timeLabel.text = comment.publishedDateText
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    selectionStyle = .none
    backgroundColor = .clear
    contentView.backgroundColor = .clear
  }
}
