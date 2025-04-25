import Domain
import SwiftUI
import Theme

extension VolumeCardFeature {
  struct SaleabilityBadgeView: View {

    // MARK: - Properties

    let saleability: Volume.Saleability

    init (saleability: Volume.Saleability) {
      self.saleability = saleability
    }

    // MARK: - Body

    var body: some View {
      BadgeView(
        caption: saleability.caption,
        color: saleability.badgeColor
      )
    }
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
    }
  }
}
