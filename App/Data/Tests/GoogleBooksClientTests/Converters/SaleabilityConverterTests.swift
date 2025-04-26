import Domain
import Testing

@testable import GoogleBooksClient

@Suite
struct SaleabilityConverterTests {
  @Test
  func sut_should_convert_domain_model() {
    let sut = SaleabilityConverter.live()

    #expect(sut.convertToDomain(from: "FREE") == .free)
    #expect(sut.convertToDomain(from: "NOT_FOR_SALE") == .notForSale)
    #expect(sut.convertToDomain(from: "FOR_SALE") == .forSale)
    #expect(sut.convertToDomain(from: "FOR_PREORDER") == .preorder)
    #expect(sut.convertToDomain(from: "UNKNOWN_VALUE") == .unknown)
  }
}
