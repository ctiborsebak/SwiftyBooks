import Foundation

public protocol RequestBuilderClientProtocol: Sendable {
  func buildRequestWithBaseURL(_ baseURL: String) throws -> URLRequest
  func withPath(_ request: URLRequest, _ path: String) throws -> URLRequest
  func withMethod(_ request: URLRequest, _ method: HTTPMethod) -> URLRequest
  func withQueryItems(_ request: URLRequest, _ queryItems: [URLQueryItem]) throws -> URLRequest
}

public struct LiveRequestBuilderClient: RequestBuilderClientProtocol {
  public init() {}

  public func buildRequestWithBaseURL(_ baseURL: String) throws -> URLRequest {
    guard let url = URL(string: baseURL) else {
      throw NetworkError.invalidURL
    }

    return URLRequest(url: url)
  }

  public func withPath(_ request: URLRequest, _ path: String) throws -> URLRequest {
    guard var url = request.url else {
      throw NetworkError.invalidURL
    }

    url.appendPathComponent(path)

    var updatedRequest = request
    updatedRequest.url = url

    return updatedRequest
  }

  public func withMethod(_ request: URLRequest, _ method: HTTPMethod) -> URLRequest {
    var request = request
    request.httpMethod = method.rawValue

    return request
  }

  public func withQueryItems(_ request: URLRequest, _ queryItems: [URLQueryItem]) throws -> URLRequest {
    guard
      let url = request.url,
      var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      throw NetworkError.invalidURL
    }

    components.queryItems = queryItems

    guard let newURL = components.url else {
      throw NetworkError.invalidURL
    }

    var updatedRequest = request
    updatedRequest.url = newURL
    return updatedRequest
  }
}
