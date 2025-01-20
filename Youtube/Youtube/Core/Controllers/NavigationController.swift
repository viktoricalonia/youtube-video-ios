import Foundation

import UIKit

class NavigationController: UINavigationController {
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setDefaultAttributes()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setDefaultAttributes()
  }

  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    setDefaultAttributes()
  }

  override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
    super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    setDefaultAttributes()
  }

  init() {
    super.init(nibName: nil, bundle: nil)
    setDefaultAttributes()
  }

  func setDefaultAttributes() {
    let font = UIFont.systemFont(ofSize: 20)
    let titleTextColor = UIColor.black
    navigationBar.titleTextAttributes = [
      .font: font,
      .foregroundColor: titleTextColor
    ]

    navigationBar.barTintColor = titleTextColor
  }
}
