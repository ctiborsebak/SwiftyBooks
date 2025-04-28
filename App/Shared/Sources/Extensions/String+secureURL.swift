import Foundation

public extension String {
  /// Replaces `http` with `https` if possible.
  var secureURL: String {
    replacingOccurrences(of: "http://", with: "https://")
  }
}
