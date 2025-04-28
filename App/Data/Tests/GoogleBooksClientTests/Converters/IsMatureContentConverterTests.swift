import Domain
import Testing

@testable import GoogleBooksClient

struct IsMatureContentConverterTests {
  @Test
  func sut_should_convert_domain_model() {
    let sut = IsMatureContentConverter.live()

    #expect(sut.convertToDomain(from: "NOT_MATURE") == false)
    #expect(sut.convertToDomain(from: "MATURE") == true)
    #expect(sut.convertToDomain(from: nil) == true)
  }
}
