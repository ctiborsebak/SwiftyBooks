import Foundation
import Networking

extension GoogleBooksClient {
  static func live(
    requestBuilder: RequestBuilderClientProtocol,
    urlSessionClient: URLSessionClientProtocol,
    volumesConverter: VolumesConverter
  ) -> Self {
    .init { searchQuery, lastItemIndex in
      var request: URLRequest

      do {
        request = try requestBuilder.buildRequestWithBaseURL(GoogleBooksAPI.baseURL)
        request = try requestBuilder.withPath(request, "/volumes")
        request = requestBuilder.withMethod(request, .get)
        request = try requestBuilder.withQueryItems(
          request, [
            .init(name: "q", value: searchQuery),
            .init(name: "maxResults", value: "10"),
            .init(name: "startIndex", value: "\(lastItemIndex)"),
            .init(name: "key", value: GoogleBooksAPI.apiKey)
          ]
        )
      } catch {
        return .failure(.requestFailed)
      }

      do {
        let response = try await urlSessionClient.execute(request, as: VolumesResponse.self)

        guard let volumes = volumesConverter.convertToDomain(from: response) else {
          return .failure(.decodingFailed)
        }

        return .success(volumes)
      } catch {
        return .failure(.requestFailed)
      }
    }
  }
}
