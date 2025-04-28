import Domain
import ModelConverter

typealias SaleabilityConverter = ModelConverter<Volume.Saleability, String>

extension SaleabilityConverter {
  static func live() -> Self {
    .init { response in
      switch response {
      case "FREE":
        return .free

      case "NOT_FOR_SALE":
        return .notForSale

      case "FOR_SALE":
        return .forSale

      case "FOR_PREORDER":
        return .preorder

      default:
        return .unknown
      }
    }
  }
}
