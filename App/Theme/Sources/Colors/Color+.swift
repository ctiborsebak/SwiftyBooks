import SwiftUI

public extension Color {
  enum Accent {
    public static let primary = Color(.accentPrimary)
    public static let secondary = Color(.accentSecondary)
  }

  enum Background {
    public static let primary = Color(.backgroundPrimary)
    public static let card = Color(.backgroundCard)
  }

  enum Neutral {
    public static let primary = Color(.neutralPrimary)
  }

  enum Semantic {
    public static let info = Color(.info)
    public static let negative = Color(.negative)
    public static let positive = Color(.positive)
  }

  enum Text {
    public static let button = Color(.textButton)
    public static let primary = Color(.textPrimary)
    public static let secondary = Color(.textSecondary)
  }
}
