import Domain
import SwiftUI

public struct SaleabilityBadgeView: View {
  // MARK: - Properties

  public let saleability: Volume.Saleability

  public init (saleability: Volume.Saleability) {
    self.saleability = saleability
  }

  // MARK: - Body

  public var body: some View {
    BadgeView(
      caption: saleability.caption,
      color: saleability.badgeColor
    )
  }
}

extension Volume.Saleability {
  var caption: String {
    switch self {
    case .preorder:
      "Pre-order"

    case .forSale:
      "For sale"

    case .notForSale:
      "Not for sale"

    case .free:
      "Free"

    case .unknown:
      ""
    }
  }

  var badgeColor: Color {
    switch self {
    case .preorder:
      .Semantic.info

    case .forSale:
      .Semantic.info

    case .free:
      .Semantic.positive

    case .notForSale:
      .Semantic.negative

    case .unknown:
      .clear
    }
  }
}
