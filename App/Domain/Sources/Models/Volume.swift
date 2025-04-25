public struct Volume: Equatable, Identifiable {
  public let id: String
  public let title: String
  public let authors: [String]
  public let description: String
  public let thumbnailImageURLPath: String
  public let isMatureContent: Bool
  public let publishedYear: String
  public let saleability: Saleability
  public let averageRating: Double

  public enum Saleability {
    case preorder
    case forSale
    case notForSale
    case free
  }
}
