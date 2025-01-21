//
//  UIViewController+ProgressPresenter.swift
//  Poplar
//
//  Created by viktor calonia on 8/16/24.
//

import Foundation
import UIKit

import SVProgressHUD

public protocol ProgressHUDPresenter {
  func show()

  func showProgress(_ progress: Float)

  func showDismissableError(with status: String)

  func showDismissableInfo(with status: String)

  func showDismissableSuccess(with status: String)

  func dismiss()
}

extension UIViewController: ProgressHUDPresenter {
  public func show() {
    SVProgressHUD.show()
  }

  public func showProgress(_ progress: Float) {
    SVProgressHUD.showProgress(progress)
  }

  public func showDismissableError(with status: String) {
    SVProgressHUD.showDismissableError(with: status)
  }

  public func showDismissableInfo(with status: String) {
    SVProgressHUD.showDismissableInfo(with: status)
  }

  public func showDismissableSuccess(with status: String) {
    SVProgressHUD.showDismissableSuccess(with: status)
  }

  public func dismiss() {
    SVProgressHUD.dismiss()
  }
}
