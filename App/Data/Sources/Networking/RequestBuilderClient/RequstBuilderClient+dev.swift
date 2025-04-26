import Foundation

extension RequestBuilderClient {
  static var dev: Self {
    .init(
      buildRequestWithBaseURL: { baseURL in
        guard let url = URL(string: baseURL) else {
          throw NetworkError.invalidURL
        }

        return URLRequest(url: url)
      },
      withPath: { request, string in
        return request
      },
      withMethod: { request, method in
        return request
      },
      withQueryItems: { request, queryItems in
        return request
      }
    )
  }
}
