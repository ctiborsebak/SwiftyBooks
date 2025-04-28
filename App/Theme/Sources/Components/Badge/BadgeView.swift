import SwiftUI

public struct BadgeView: View {

  // MARK: - Properties

  let caption: String
  let color: Color

  public init(
    caption: String,
    color: Color
  ) {
    self.caption = caption
    self.color = color
  }

  public var body: some View {
    Text(caption)
      .font(.system(.caption))
      .padding(.vertical, .Spacing.XXXS)
      .padding(.horizontal, .Spacing.XS)
      .foregroundStyle(color)
      .background {
        color.opacity(.Opacity.badge)
          .cornerRadius(.CornerRadius.XS)
      }
  }
}
