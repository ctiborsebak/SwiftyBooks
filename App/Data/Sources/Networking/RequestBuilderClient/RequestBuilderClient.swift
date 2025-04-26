import Dependencies
import Foundation

public struct RequestBuilderClient: Sendable {
  var buildRequestWithBaseURL: @Sendable (String) throws -> URLRequest
  var withPath: @Sendable (URLRequest, String) throws -> URLRequest
  var withMethod: @Sendable (URLRequest, HTTPMethod) -> URLRequest
  var withQueryItems: @Sendable (URLRequest, [URLQueryItem]) throws -> URLRequest
}

// MARK: - Dependencies

public extension DependencyValues {
  var requestBuilderClient: RequestBuilderClient {
    get { self[RequestBuilderClient.self] }
    set { self[RequestBuilderClient.self] = newValue }
  }
}

extension RequestBuilderClient: DependencyKey {
  public static let liveValue: RequestBuilderClient = .live
  public static let testValue: RequestBuilderClient = .mock()
#if DEBUG
  public static let previewValue: RequestBuilderClient = .dev
#endif
}
