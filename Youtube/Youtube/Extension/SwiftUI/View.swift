import Foundation
import UIKit
import SwiftUI

extension View {
  var uiView: UIView {
    let hostingVC = UIHostingController(rootView: self)
    return hostingVC.view
  }
}
