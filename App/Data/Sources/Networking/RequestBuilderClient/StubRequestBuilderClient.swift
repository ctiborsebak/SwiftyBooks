import Foundation

public struct StubRequestBuilderClient: RequestBuilderClientProtocol {
  let urlRequest: URLRequest?
  let error: NetworkError?

  public init(urlRequest: URLRequest?, error: NetworkError?) {
    self.urlRequest = urlRequest
    self.error = error
  }

  public func buildRequestWithBaseURL(_ baseURL: String) throws -> URLRequest {
    guard let urlRequest else {
      throw error ?? .requestFailed
    }

    return urlRequest
  }

  public func withPath(_ request: URLRequest, _ path: String) throws -> URLRequest {
    guard let urlRequest else {
      throw error ?? .requestFailed
    }

    return urlRequest
  }

  public func withMethod(_ request: URLRequest, _ method: HTTPMethod) -> URLRequest {
    return urlRequest ?? request
  }

  public func withQueryItems(_ request: URLRequest, _ queryItems: [URLQueryItem]) throws -> URLRequest {
    guard let urlRequest else {
      throw error ?? .requestFailed
    }

    return urlRequest
  }
}
