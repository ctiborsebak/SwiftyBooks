import Dependencies
import Foundation
import Testing

@testable import Networking

struct MockResponse: Codable, Equatable {
  var id: Int
  var name: String
}

@Test
func test_execute_returns_data() async throws {
  let mockData = Data("Test data".utf8)

  let client = URLSessionClient(
    execute: { _ in mockData }
  )

  let request = URLRequest(url: try #require(URL(string: "https://example.com")))

  let data = try await client.execute(request)

  #expect(data == mockData)
}

@Test
func test_decode_decodes_response_successfully() async throws {
  let mockResponse = MockResponse(id: 1, name: "Test")
  let mockData = try JSONEncoder().encode(mockResponse)

  let client = URLSessionClient(
    execute: { _ in mockData }
  )

  let request = URLRequest(url: try #require(URL(string: "https://example.com")))

  let decoded = try await client.decode(request, as: MockResponse.self)

  #expect(decoded == mockResponse)
}

@Test
func test_decode_throws_on_invalid_data() async throws {
  let invalidData = Data("Invalid JSON".utf8)

  let client = URLSessionClient(
    execute: { _ in invalidData }
  )

  let request = URLRequest(url: try #require(URL(string: "https://example.com")))

  await #expect(throws: NetworkError.decodingFailed) {
    try await client.decode(request, as: MockResponse.self)
  }
}
