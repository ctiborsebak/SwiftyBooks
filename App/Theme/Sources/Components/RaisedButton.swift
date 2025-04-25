import SwiftUI

public struct RaisedButton: View {
  let caption: String
  let action: () -> Void

  public init(
    caption: String,
    action: @escaping () -> Void
  ) {
    self.caption = caption
    self.action = action
  }

  public var body: some View {
    Button {
      action()
    } label: {
      Text(caption)
        .font(.subheadline)
        .foregroundStyle(Color.Text.button)
        .padding(.vertical, .Spacing.XXS)
        .padding(.horizontal, .Spacing.S)
        .background {
          Color.Accent.primary
            .cornerRadius(.CornerRadius.XS)
        }
        .frame(minWidth: .minimalTappableDimension, minHeight: .minimalTappableDimension)
    }
  }
}

#if DEBUG
#Preview {
  RaisedButton(
    caption: "Button",
    action: {}
  )
}
#endif
