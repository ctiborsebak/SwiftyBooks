import Domain
import Testing

@testable import GoogleBooksClient

struct VolumeConverterTests {
  @Test
  func sut_should_convert_domain_model() {
    let isMatureContentConverter = IsMatureContentConverter { _ in
      false
    }
    let saleabilityConverter = SaleabilityConverter { _ in
        .forSale
    }
    let priceConverter = PriceConverter { _ in
        .init(amount: 15.0, currencyCode: "USD")
    }
    let sut = VolumeConverter.live(
      isMatureContentConverter: isMatureContentConverter,
      saleabilityConverter: saleabilityConverter,
      priceConverter: priceConverter
    )

    let response = VolumeResponse(
      id: "volume1",
      volumeInfo: .init(
        title: "Sample Title",
        authors: ["Author1", "Author2"],
        publishedDate: "2024",
        description: "A sample description.",
        imageLinks: .init(thumbnail: "http://example.com/thumb.jpg"),
        maturityRating: "NOT_MATURE"
      ),
      saleInfo: .init(
        saleability: "FOR_SALE",
        listPrice: .init(amount: 15.0, currencyCode: "USD"),
        buyLink: "https://buy.me"
      )
    )

    let domainModel = sut.convertToDomain(from: response)

    #expect(domainModel?.id == "volume1")
    #expect(domainModel?.title == "Sample Title")
    #expect(domainModel?.authors == ["Author1", "Author2"])
    #expect(domainModel?.description == "A sample description.")
    #expect(domainModel?.thumbnailImageURLPath == "http://example.com/thumb.jpg")
    #expect(domainModel?.isMatureContent == false)
    #expect(domainModel?.publishedYear == "2024")
    #expect(domainModel?.saleability == .forSale)
    #expect(domainModel?.price == Volume.Price(amount: 15.0, currencyCode: "USD"))
    #expect(domainModel?.buyLink == "https://buy.me")
  }
}
