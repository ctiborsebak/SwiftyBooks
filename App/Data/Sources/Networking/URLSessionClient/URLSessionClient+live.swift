import Dependencies
import Foundation

public extension URLSessionClient {
  static let live = URLSessionClient(
    execute: { request in
      let (data, _) = try await URLSession.shared.data(for: request)
      return data
    }
  )
}

public extension URLSessionClient {
  func decode<Response: Decodable>(
    _ request: URLRequest,
    as responseType: Response.Type
  ) async throws -> Response {
    let data = try await execute(request)
    do {
      return try JSONDecoder().decode(Response.self, from: data)
    } catch {
#if DEBUG
      @Dependency(\.loggerClient) var logger
      logger.log("‼️ Failed to decode \(Response.self): \(error)")
#endif
      throw NetworkError.decodingFailed
    }
  }
}
