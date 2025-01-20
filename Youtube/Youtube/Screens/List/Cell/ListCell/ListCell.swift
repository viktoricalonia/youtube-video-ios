//
//  ListTableController.swift
//  Youtube
//
//  Created by Viktor Immanuel Calonia on 1/20/25.
//

import Foundation
import UIKit

import SDWebImage

class ListCell: UITableViewCell {

  @IBOutlet var thumbnailImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!

  var viewModel: Video? {
    didSet {
      guard let viewModel = viewModel else { return }
      titleLabel.text = viewModel.title
      if let url = URL(string: viewModel.thumbnailUrlString) {
        thumbnailImageView.sd_setImage(with: url)
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    selectionStyle = .none
    backgroundColor = .clear
    contentView.backgroundColor = .clear
  }
}
