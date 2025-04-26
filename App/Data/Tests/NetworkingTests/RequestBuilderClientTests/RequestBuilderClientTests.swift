import Foundation
import Testing

@testable import Networking

struct RequestBuilderClientTests {
  @Test
  func sut_should_create_an_url_request() {
    let sut = RequestBuilderClient.live

    let result = try? sut.buildRequestWithBaseURL("https://www.google.com")

    #expect(result?.url?.absoluteString == "https://www.google.com")
  }

  @Test
  func sut_should_throw_an_error_when_url_is_invalid() {
    let sut = RequestBuilderClient.live

    #expect(throws: NetworkError.invalidURL) {
      try sut.buildRequestWithBaseURL("")
    }
  }

  @Test
  func sut_should_create_an_url_request_with_path() throws {
    let sut = RequestBuilderClient.live
    let url = try #require(URL(string: "https://www.google.com"))
    let request = URLRequest(url: url)

    let result = try? sut.withPath(request, "/search")

    #expect(result?.url?.absoluteString == "https://www.google.com/search")
  }

  @Test
  func sut_should_create_an_url_request_with_http_method() throws {
    let sut = RequestBuilderClient.live
    let url = try #require(URL(string: "https://www.google.com"))
    let request = URLRequest(url: url)

    let result = sut.withMethod(request, .get)

    #expect(result.httpMethod == "GET")
  }

  @Test
  func sut_should_add_query_items_to_a_request() throws {
    let sut = RequestBuilderClient.live
    let url = try #require(URL(string: "https://www.google.com"))
    let request = URLRequest(url: url)

    let queryItems = [
      URLQueryItem(name: "q", value: "swift"),
      URLQueryItem(name: "page", value: "1")
    ]

    let result = try? sut.withQueryItems(request, queryItems)

    #expect(result?.url?.absoluteString == "https://www.google.com?q=swift&page=1")
  }

  @Test
  func sut_should_throw_when_request_url_is_nil_when_adding_query_irems() throws {
    let sut = RequestBuilderClient.live
    var request = URLRequest(url: try #require(URL(string: "https://example.com")))
    request.url = nil

    #expect(throws: NetworkError.invalidURL) {
      try sut.withQueryItems(request, [])
    }
  }
}
