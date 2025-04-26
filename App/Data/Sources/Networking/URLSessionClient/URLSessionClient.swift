import Foundation

public protocol URLSessionClientProtocol: Sendable {
  func execute<T: Decodable>(_ request: URLRequest, as type: T.Type) async throws -> T
}

public struct LiveURLSessionClient: URLSessionClientProtocol {
  public static let shared = LiveURLSessionClient()

  var session: URLSession

  public init(configuration: URLSessionConfiguration = .default) {
    self.session = URLSession(configuration: configuration)
  }

  public func execute<T: Decodable>(_ request: URLRequest, as type: T.Type) async throws -> T {
    let (data, _) = try await session.data(for: request)

    var decodedObject: T

    do {
      decodedObject =  try JSONDecoder().decode(T.self, from: data)
    } catch {
      throw NetworkError.decodingFailed
    }

    return decodedObject
  }
}
