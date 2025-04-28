import SwiftUI

private struct CenteredHorizontallyModifier: ViewModifier {
  let alignment: VerticalAlignment

  func body(content: Content) -> some View {
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
