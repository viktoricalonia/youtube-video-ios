import Foundation

import UIKit

extension UIViewController {
  var isVisible: Bool {
    if let tabbar = tabBarController {
      return tabbar.selectedViewController === self && viewIfLoaded?.window != nil
    } else {
      return viewIfLoaded?.window != nil
    }
  }
}
