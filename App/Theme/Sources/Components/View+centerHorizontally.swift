import SwiftUI

public struct CenteredInHStackModifier: ViewModifier {
  public func body(content: Content) -> some View {
    HStack {
      Spacer()

      content

      Spacer()
    }
  }
}

public extension View {
  func centerHorizontally() -> some View {
    self.modifier(CenteredInHStackModifier())
  }
}
