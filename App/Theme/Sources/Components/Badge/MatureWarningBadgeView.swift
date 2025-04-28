import SwiftUI

public struct MatureWarningBadgeView: View {

  // MARK: - Properties

  public let isMatureContent: Bool

  public init(isMatureContent: Bool) {
    self.isMatureContent = isMatureContent
  }

  // MARK: - Body

  public var body: some View {
    switch isMatureContent {
    case true:
      BadgeView(
        caption: "18+",
        color: Color.Semantic.negative
      )
    case false:
      EmptyView()
    }
  }
}
