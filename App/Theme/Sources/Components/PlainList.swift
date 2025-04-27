import SwiftUI

public struct PlainList<Content: View>: View {
  let spacing: CGFloat
  let padding: CGFloat
  @ViewBuilder let content: () -> Content

  public init(
    spacing: CGFloat = .Spacing.S,
    padding: CGFloat = .zero,
    content: @escaping () -> Content
  ) {
    self.spacing = spacing
    self.padding = padding
    self.content = content
  }

  public var body: some View {
    List {
      content()
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
    }
    .background(Color.clear)
    .listStyle(.plain)
    .listRowSpacing(spacing)
    .padding(padding)
    .scrollIndicators(.never)
  }
}
