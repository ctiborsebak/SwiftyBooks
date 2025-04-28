import SafariServices
import SwiftUI

public struct SafariView: UIViewControllerRepresentable {
  public  let url: URL

  public init(url: URL) {
    self.url = url
  }

  public func makeUIViewController(context: Context) -> SFSafariViewController {
    SFSafariViewController(url: url)
  }

  public func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
