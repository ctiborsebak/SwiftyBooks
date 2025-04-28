import SwiftUI

private struct CenteredHorizontallyModifier: ViewModifier {
  public let alignment: VerticalAlignment

  public init(alignment: VerticalAlignment) {
    self.alignment = alignment
  }

  public func body(content: Content) -> some View {
    HStack(alignment: alignment) {
      Spacer()

      content

      Spacer()
    }
  }
}

public extension View {
  func centerHorizontally(alignment: VerticalAlignment = .center) -> some View {
    self.modifier(CenteredHorizontallyModifier(alignment: alignment))
  }
}
