import SwiftUI
import Theme

struct BookImagePlaceholderView: View {
  @State private var bookPlaceholderImageOpacity = Double.Opacity.badge

  var body: some View {
    Rectangle()
      .cornerRadius(.CornerRadius.S)
      .foregroundStyle(Color.Neutral.primary)
      .frame(maxWidth: UIScreen.main.bounds.width * 0.25)
      .opacity(bookPlaceholderImageOpacity)
      .animation(
        .easeInOut(duration: 1.0)
        .repeatForever(
          autoreverses: true
        ),
        value: bookPlaceholderImageOpacity
      )
      .onAppear {
        bookPlaceholderImageOpacity = 1.0
      }
  }
}
