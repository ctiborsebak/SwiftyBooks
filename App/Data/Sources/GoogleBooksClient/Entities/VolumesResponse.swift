import Foundation

struct VolumesResponse: Equatable, Decodable {
  let totalitems: Int
  let items: [VolumeResponse]
}

struct VolumeResponse: Equatable, Decodable {
  let id: String
  let volumeInfo: VolumeInfoResponse
  let saleInfo: SaleInfoResponse?
}

struct VolumeInfoResponse: Equatable, Decodable {
  let title: String
  let authors: [String]
  let publishedDate: String?
  let description: String?
  let imageLinks: ImageLinkResponse?
  let maturityRating: String?
}

struct ImageLinkResponse: Equatable, Decodable {
  let thumbnail: String?
}

struct SaleInfoResponse: Equatable, Decodable {
  let saleability: String?
  let listPrice: ListPriceResponse?
}

struct ListPriceResponse: Equatable, Decodable {
  let amount: Double
  let currencyCode: String
}
