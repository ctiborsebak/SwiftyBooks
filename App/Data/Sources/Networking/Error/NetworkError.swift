import Foundation

public enum NetworkError: Error, Equatable {
  case decodingFailed
  case invalidData
  case invalidResponse
  case invalidURL
  case requestFailed
}
