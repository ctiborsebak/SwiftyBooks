import Dependencies
import Domain
import Foundation
import ModelConverter
import Networking

public struct GoogleBooksClient: Sendable {
  public var search: @Sendable (String, Int) async -> Result<Volumes, NetworkError>
}

// MARK: - Dependencies

public extension DependencyValues {
  var googleBooksClient: GoogleBooksClient {
    get { self[GoogleBooksClient.self] }
    set { self[GoogleBooksClient.self] = newValue }
  }
}

extension GoogleBooksClient: DependencyKey {
  public static let liveValue: GoogleBooksClient = .live(
    requestBuilder: LiveRequestBuilderClient(),
    urlSessionClient: LiveURLSessionClient.shared,
    volumesConverter: .live(
      volumeConverter: .live(
        isMatureContentConverter: .live(),
        saleabilityConverter: .live(),
        priceConverter: .live()
      )
    )
  )

  public static let testValue: GoogleBooksClient = .mock()
}
