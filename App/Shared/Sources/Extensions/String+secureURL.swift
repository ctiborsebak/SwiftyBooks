import Foundation

public extension String {
  var secureURL: String {
    replacingOccurrences(of: "http://", with: "https://")
  }
}
