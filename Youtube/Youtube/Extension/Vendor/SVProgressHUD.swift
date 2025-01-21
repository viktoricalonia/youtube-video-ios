//
//  SVProgressHUD.swift
//  Youtube
//
//  Created by viktor calonia on 1/21/25.
//

import Foundation

import SVProgressHUD

/// Remove HUD on Tap Ref: https://stackoverflow.com/a/41111242/425694
extension SVProgressHUD {
  static func show(
    message: String? = nil,
    mask: SVProgressHUDMaskType = .none,
    foregroundColor: UIColor? = nil,
    backgroundColor: UIColor? = nil
  ) {
    SVProgressHUD.setDefaultMaskType(mask)
    if let fgColor = foregroundColor {
      SVProgressHUD.setForegroundColor(fgColor)
    }
    if let bgColor = backgroundColor {
      SVProgressHUD.setBackgroundColor(bgColor)
    }
    SVProgressHUD.show(withStatus: message)
  }

  static func showDismissableError(with status: String) {
    addHUDNotificationObservers()
    SVProgressHUD.showError(withStatus: status)
    SVProgressHUD.setDefaultMaskType(.clear)
  }

  static func showDismissableInfo(with status: String) {
    addHUDNotificationObservers()
    SVProgressHUD.showInfo(withStatus: status)
    SVProgressHUD.setDefaultMaskType(.clear)
  }

  static func showDismissableSuccess(with status: String) {
    addHUDNotificationObservers()
    SVProgressHUD.showSuccess(withStatus: status)
    SVProgressHUD.setDefaultMaskType(.clear)
  }

  private static func addHUDNotificationObservers() {
    let nc = NotificationCenter.default
    nc.addObserver(
      self, selector: #selector(hudTapped(_:)),
      name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent,
      object: nil
    )
    nc.addObserver(
      self, selector: #selector(hudDisappeared(_:)),
      name: NSNotification.Name.SVProgressHUDWillDisappear,
      object: nil
    )
  }

  @objc
  private static func hudTapped(_ notification: Notification) {
    SVProgressHUD.dismiss()
    SVProgressHUD.setDefaultMaskType(.none)
  }

  @objc
  private static func hudDisappeared(_ notification: Notification) {
    let nc = NotificationCenter.default
    nc.removeObserver(self, name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent, object: nil)
    nc.removeObserver(self, name: NSNotification.Name.SVProgressHUDWillDisappear, object: nil)
    SVProgressHUD.setDefaultMaskType(.none)
  }
}
