import Foundation

enum NetworkError: Error, Equatable {
  case invalidURL
  case requestFailed
  case invalidResponse
  case invalidData
  case decodingFailed
}
