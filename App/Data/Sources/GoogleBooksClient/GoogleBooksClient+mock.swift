import Domain
import Networking
import XCTestDynamicOverlay

extension GoogleBooksClient {
  static func mock(
    search: @Sendable @escaping (String, Int) async -> Result<Volumes, NetworkError> = unimplemented(
      "\(Self.self).search",
      placeholder: .failure(.requestFailed)
    )
  ) -> Self {
    .init(
      search: search
    )
  }
}
