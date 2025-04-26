import Domain
import XCTestDynamicOverlay

extension GoogleBooksClient {
  static func mock(
    search: @Sendable @escaping (String, Int) async throws -> Volumes = unimplemented(
      "\(Self.self).search"
    )
  ) -> Self {
    .init(
      search: search
    )
  }
}
