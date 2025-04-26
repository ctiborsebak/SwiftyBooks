import Foundation

public struct StubURLSessionClient<T: Decodable & Sendable>: URLSessionClientProtocol {
  private let mockObject: T?
  private let mockError: Error?

  public init(mockObject: T? = nil, mockError: Error? = nil) {
    self.mockObject = mockObject
    self.mockError = mockError
  }

  public func execute<U: Decodable>(_ request: URLRequest, as type: U.Type) async throws -> U {
    if let error = mockError {
      throw error
    }

    guard let result = mockObject as? U else {
      throw NSError(domain: "StubURLSessionClient", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mismatched types"])
    }
    return result
  }
}
