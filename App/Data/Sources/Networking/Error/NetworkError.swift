import Foundation

enum NetworkError: Error, Equatable {
  case invalidURL
  case requestFailed
  case invalidResponse(statusCode: Int, data: Data)
  case invalidData
  case decodingFailed
}
