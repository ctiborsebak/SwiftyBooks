import SwiftUI
import Theme

extension VolumeCardFeature {
  struct MatureWarningBadgeView: View {

    // MARK: - Properties

    let isMatureContent: Bool

    init(isMatureContent: Bool) {
      self.isMatureContent = isMatureContent
    }

    // MARK: - Body

    var body: some View {
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
}
