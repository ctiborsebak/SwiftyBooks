import Domain
import ModelConverter

typealias PriceConverter = ModelConverter<Volume.Price, ListPriceResponse>

extension PriceConverter {
  static func live() -> Self {
    .init { response in
      .init(
        amount: response.amount,
        currencyCode: response.currencyCode
      )
    }
  }
}
