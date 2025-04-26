import Foundation
import XCTestDynamicOverlay

public extension URLSessionClient {
  static func mock(
    execute: @Sendable @escaping (URLRequest) async throws -> Data = unimplemented(
      "\(Self.self).execute"
    )
  ) -> URLSessionClient {
    URLSessionClient(execute: execute)
  }

  static func mockSuccess(data: Data) -> URLSessionClient {
    URLSessionClient(
      execute: { _ in data }
    )
  }

  static func mockFailure(error: Error) -> URLSessionClient {
    URLSessionClient(
      execute: { _ in throw error }
    )
  }
}
