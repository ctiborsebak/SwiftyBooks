import Foundation
import Testing

@testable import Networking

@Suite
struct URLSessionClientTests {
  @Test
  func testFetchUserSuccessfully() async throws {
    let mockClient = MockURLSessionClient()
    let url = URL(string: "https://api.example.com/users/1")!
    let mockUser = User(id: 1, name: "John Doe")

    try await mockClient.register(url: url, value: mockUser)

    let request = URLRequest(url: url)

    let result = try await mockClient.execute(request, as: User.self)

    #expect(result == mockUser)
    let executedRequests = await mockClient.executedRequests()
    #expect(executedRequests.count == 1)
    #expect(executedRequests[0].url == url)
  }

  @Test
  func testFetchUserWithError() async {
    var erroredOut = false
    let mockClient = MockURLSessionClient()
    let url = URL(string: "https://api.example.com/users/1")!
    let mockUser = User(id: 1, name: "John Doe")

    struct NetworkError: Error {}
    let testError = NetworkError()

    do {
      try await mockClient.register(url: url, value: mockUser, error: testError)
    } catch {
      erroredOut = true
    }

    let request = URLRequest(url: url)

    await #expect(throws: NetworkError.self) {
      try await mockClient.execute(request, as: User.self)
    }
    let executedRequests = await mockClient.executedRequests()
    #expect(executedRequests.count == 1)
    #expect(!erroredOut)
  }
}

// MARK: - Helpers

public struct MockResponse : Sendable{
  let data: Data
  let statusCode: Int
  let error: Error?

  public init<T: Encodable>(value: T, statusCode: Int = 200, error: Error? = nil) throws {
    self.data = try JSONEncoder().encode(value)
    self.statusCode = statusCode
    self.error = error
  }

  public init(data: Data, statusCode: Int = 200, error: Error? = nil) {
    self.data = data
    self.statusCode = statusCode
    self.error = error
  }
}

private actor MockStorage {
  var mockResponses: [URL: MockResponse] = [:]
  var executedRequests: [URLRequest] = []

  func register(url: URL, response: MockResponse) {
    mockResponses[url] = response
  }

  func getResponse(for url: URL) -> MockResponse? {
    return mockResponses[url]
  }

  func addExecutedRequest(_ request: URLRequest) {
    executedRequests.append(request)
  }

  func getExecutedRequests() -> [URLRequest] {
    return executedRequests
  }
}

public final class MockURLSessionClient: URLSessionClientProtocol {
  private let storage = MockStorage()

  public init() {}

  public func register<T: Encodable>(url: URL, value: T, statusCode: Int = 200, error: Error? = nil) async throws {
    let response = try MockResponse(value: value, statusCode: statusCode, error: error)
    await storage.register(url: url, response: response)
  }

  public func register(url: URL, data: Data, statusCode: Int = 200, error: Error? = nil) async {
    let response = MockResponse(data: data, statusCode: statusCode, error: error)
    await storage.register(url: url, response: response)
  }

  public func executedRequests() async -> [URLRequest] {
    return await storage.getExecutedRequests()
  }

  public func execute<T: Decodable>(_ request: URLRequest, as type: T.Type) async throws -> T {
    await storage.addExecutedRequest(request)

    guard let url = request.url else {
      throw NSError(domain: "MockURLSessionClient", code: 1, userInfo: [NSLocalizedDescriptionKey: "Request URL is nil"])
    }

    guard let mockResponse = await storage.getResponse(for: url) else {
      throw NSError(domain: "MockURLSessionClient", code: 2, userInfo: [NSLocalizedDescriptionKey: "No mock response registered for URL: \(url)"])
    }

    if let error = mockResponse.error {
      throw error
    }

    let decodedObject = try JSONDecoder().decode(T.self, from: mockResponse.data)
    return decodedObject
  }
}

struct User: Codable, Equatable {
  let id: Int
  let name: String
}
