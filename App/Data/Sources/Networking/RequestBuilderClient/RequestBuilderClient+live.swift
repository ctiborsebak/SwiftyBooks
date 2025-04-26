import Foundation

extension RequestBuilderClient {
  static var live: Self {
    .init(
      buildRequestWithBaseURL: { baseURL in
        guard let url = URL(string: baseURL) else {
          throw NetworkError.invalidURL
        }

        return URLRequest(url: url)
      },
      withPath: { request, path in
        guard var url = request.url else {
          throw NetworkError.invalidURL
        }

        url.appendPathComponent(path)

        var updatedRequest = request
        updatedRequest.url = url

        return updatedRequest
      },
      withMethod: { request, method in
        var request = request
        request.httpMethod = method.rawValue

        return request
      },
      withQueryItems: { request, queryItems in
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
    )
  }
}
