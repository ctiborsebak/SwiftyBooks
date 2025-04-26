import Dependencies
import Foundation

public struct URLSessionClient: Sendable {
  public var execute: @Sendable (URLRequest) async throws -> Data
}

public extension DependencyValues {
  var urlSessionClient: URLSessionClient {
    get { self[URLSessionClient.self] }
    set { self[URLSessionClient.self] = newValue }
  }
}

extension URLSessionClient: DependencyKey {
  public static let liveValue: URLSessionClient = .live
  public static let testValue: URLSessionClient = .mock()
}


