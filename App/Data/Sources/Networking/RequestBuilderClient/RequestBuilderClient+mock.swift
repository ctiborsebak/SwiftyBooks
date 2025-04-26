import Foundation
import XCTestDynamicOverlay

extension RequestBuilderClient {
  static func mock(
    buildRequestWithBaseURL: @Sendable @escaping (String) throws -> URLRequest = unimplemented(
      "\(Self.self).buildREquestWIthBaseURL",
      placeholder: URLRequest(url: .documentsDirectory)
    ),
    withPath: @Sendable @escaping (URLRequest, String) throws -> URLRequest = unimplemented(
      "\(Self.self).withPath",
      placeholder: URLRequest(url: .documentsDirectory)
    ),
    withMethod: @Sendable @escaping (URLRequest, HTTPMethod) -> URLRequest = unimplemented(
      "\(Self.self).withMethod",
      placeholder: URLRequest(url: .documentsDirectory)
    ),
    withQueryItems: @Sendable @escaping (URLRequest, [URLQueryItem]) throws -> URLRequest = unimplemented(
      "\(Self.self).withQueryItems",
      placeholder: URLRequest(url: .documentsDirectory)
    )
  ) -> Self {
    .init(
      buildRequestWithBaseURL: buildRequestWithBaseURL,
      withPath: withPath,
      withMethod: withMethod,
      withQueryItems: withQueryItems
    )
  }
}
