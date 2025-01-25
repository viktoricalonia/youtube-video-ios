import Foundation
import UIKit

import WebKit

final class VideoHeaderView: UIView {
  
  @IBOutlet var webView: WKWebView!
  
  var video: Video? {
    didSet {
      guard let video = video else { return }
      print("\(#file): Showingi \(video.videoEmbedUrlString)")
      webView.load(URLRequest(url: URL(string: video.videoEmbedUrlString)!))
    }
  }
}
