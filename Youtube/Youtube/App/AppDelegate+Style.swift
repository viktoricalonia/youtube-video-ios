import Foundation
import UIKit

extension AppDelegate  {
  func applyAppStyle() {
    applyNavigationStyle()
  }

  func applyNavigationStyle() {
    let customNavBarAppearance = UINavigationBarAppearance()

    let barTintColor = UIColor.darkText
    let font = UIFont.boldSystemFont(ofSize: 20)

    // Apply a red background.
    customNavBarAppearance.configureWithOpaqueBackground()
    customNavBarAppearance.backgroundColor = .darkGray
    customNavBarAppearance.shadowImage = UIImage()
    customNavBarAppearance.shadowColor = .init(white: 0, alpha: 0.2)

    // Apply white colored normal and large titles.
    customNavBarAppearance.titleTextAttributes = [
      .foregroundColor: barTintColor,
      .font: font
    ]
    customNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: barTintColor]

    // Apply white color to all the nav bar buttons.
    let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
    barButtonItemAppearance.normal.titleTextAttributes = [
      .foregroundColor: barTintColor,
      .font: font
    ]
    barButtonItemAppearance.disabled.titleTextAttributes = [
      .foregroundColor: barTintColor,
      .font: font
    ]
    barButtonItemAppearance.highlighted.titleTextAttributes = [
      .foregroundColor: barTintColor,
      .font: font
    ]
    barButtonItemAppearance.focused.titleTextAttributes = [
      .foregroundColor: barTintColor,
      .font: font
    ]
    customNavBarAppearance.buttonAppearance = barButtonItemAppearance
    customNavBarAppearance.backButtonAppearance = barButtonItemAppearance
    customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance

    let navBarAppearance = UINavigationBar.appearance()
    navBarAppearance.scrollEdgeAppearance = customNavBarAppearance
    navBarAppearance.compactAppearance = customNavBarAppearance
    navBarAppearance.standardAppearance = customNavBarAppearance
    navBarAppearance.tintColor = barTintColor
    navBarAppearance.barTintColor = barTintColor

    if #available(iOS 15.0, *) {
      navBarAppearance.compactScrollEdgeAppearance = customNavBarAppearance
    }
  }
}
