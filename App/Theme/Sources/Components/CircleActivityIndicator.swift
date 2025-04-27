import SwiftUI

public struct ActivityIndicator: View {
  @State private var isAnimating = false

  public init() { }

  public var body: some View {
    ZStack {
      Circle()
        .stroke(
          Color.gray.opacity(0.3),
          lineWidth: 4
        )
        .frame(width: 50, height: 50)

      Circle()
        .trim(from: 0, to: 0.7)
        .stroke(
          Color.Accent.secondary,
          style: StrokeStyle(
            lineWidth: 4,
            lineCap: .round
          )
        )
        .frame(width: 50, height: 50)
        .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
        .animation(
          Animation.linear(duration: 1)
            .repeatForever(autoreverses: false),
          value: isAnimating
        )
        .onAppear {
          isAnimating = true
        }
    }
  }
}



#if DEBUG
#Preview {
  ActivityIndicator()
}
#endif
