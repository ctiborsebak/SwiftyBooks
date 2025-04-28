import Testing

@testable import Shared

struct StringTests {
  @Test
  func secure_url_tests() {
    let url = "http://www.google.com"

    let sut = url.secureURL

    #expect(sut == "https://www.google.com")
  }
}
