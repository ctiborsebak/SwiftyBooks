import Dependencies
import Foundation

struct LoggerClient: Sendable {
  var log: @Sendable (_ message: String) -> Void
}

extension LoggerClient {
  static let live = LoggerClient(
    log: { message in
      print(message)
    }
  )

  static let silent = LoggerClient(
    log: { _ in }
  )
}

// MARK: - Dependencies

extension DependencyValues {
  var loggerClient: LoggerClient {
    get { self[LoggerClient.self] }
    set { self[LoggerClient.self] = newValue }
  }
}

extension LoggerClient: DependencyKey {
  public static let liveValue = LoggerClient.live
  public static let testValue = LoggerClient.silent
}
