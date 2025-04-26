import Domain
import ModelConverter

typealias VolumeConverter = ModelConverter<Volume, VolumeResponse>

extension VolumeConverter {
  static func live(
    isMatureContentConverter: IsMatureContentConverter,
    saleabilityConverter: SaleabilityConverter,
    priceConverter: PriceConverter
  ) -> Self {
    .init { response in
      let isMatureContent = isMatureContentConverter.convertToDomain(from: response.volumeInfo.maturityRating) ?? false
      let saleability = response.saleInfo?.saleability.flatMap(saleabilityConverter.convertToDomain(from:))
      let price = response.saleInfo?.listPrice.flatMap(priceConverter.convertToDomain(from:))

      return .init(
        id: response.id,
        title: response.volumeInfo.title,
        authors: response.volumeInfo.authors,
        description: response.volumeInfo.description,
        thumbnailImageURLPath: response.volumeInfo.imageLinks?.thumbnail,
        isMatureContent: isMatureContent,
        publishedYear: response.volumeInfo.publishedDate,
        saleability: saleability,
        price: price
      )
    }
  }
}
