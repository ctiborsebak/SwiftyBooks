import Domain
import Testing

@testable import GoogleBooksClient

struct VolumesConverterTests {
  @Test
  func sut_should_convert_to_domain() {
    let volumeConverter = VolumeConverter { _ in
      .init(
        id: "volume1",
        title: "Sample Title",
        authors: ["Author1, Author2"],
        description: "A sample description",
        thumbnailImageURLPath: "http://example.com/thumb.jpg",
        isMatureContent: false,
        publishedYear: "2024",
        saleability: .forSale,
        price: .init(amount: 15.0, currencyCode: "USD"),
        buyLink: nil
      )
    }
    let volumesConverter = VolumesConverter.live(volumeConverter: volumeConverter)

    let response = VolumesResponse(
      totalItems: 3,
      items: .init(
        repeating: VolumeResponse(
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
            buyLink: nil
          )
        ),
        count: 3
      ),
    )

    let domainModel = volumesConverter.convertToDomain(from: response)

    #expect(domainModel?.volumes.count == 3)
    #expect(domainModel?.totalItems == 3)
  }
}
