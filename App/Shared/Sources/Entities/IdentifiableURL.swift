import Foundation

public struct IdentifiableURL: Identifiable, Equatable {
  public let id: URL

  public init(_ url: URL) {
    self.id = url
  }
}
