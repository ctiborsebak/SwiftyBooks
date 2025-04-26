import Domain
import Testing

@testable import GoogleBooksClient

@Suite
struct PriceConverterTests {
  @Test
  func sut_should_convert_domain_model() {
    let response = ListPriceResponse(amount: 9.99, currencyCode: "USD")
    let converter = PriceConverter.live()

    let domainModel = converter.convertToDomain(from: response)

    #expect(domainModel == Volume.Price(amount: 9.99, currencyCode: "USD"))
  }
}
