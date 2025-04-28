import Testing

@testable import Shared

struct String_Tests {
  @Test
  func secure_url_tests() {
    let url = "http://www.google.com"

    let sut = url.secureURL

    #expect(sut == "https://www.google.com")
  }
}
