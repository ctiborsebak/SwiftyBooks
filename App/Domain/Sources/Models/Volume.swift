public struct Volume: Equatable, Identifiable, Sendable {
  public let id: String
  public let title: String?
  public let authors: [String]
  public let description: String?
  public let thumbnailImageURLPath: String?
  public let isMatureContent: Bool
  public let publishedYear: String?
  public let saleability: Saleability?
  public let price: Price?
  public let buyLink: String?

  public init(
    id: String,
    title: String?,
    authors: [String],
    description: String?,
    thumbnailImageURLPath: String?,
    isMatureContent: Bool,
    publishedYear: String?,
    saleability: Saleability?,
    price: Price?,
    buyLink: String?
  ) {
    self.id = id
    self.title = title
    self.authors = authors
    self.description = description
    self.thumbnailImageURLPath = thumbnailImageURLPath
    self.isMatureContent = isMatureContent
    self.publishedYear = publishedYear
    self.saleability = saleability
    self.price = price
    self.buyLink = buyLink
  }

  public enum Saleability: Equatable, Sendable {
    case preorder
    case forSale
    case notForSale
    case free
    case unknown
  }

  public struct Price: Equatable, Sendable {
    public init(
      amount: Double,
      currencyCode: String
    ) {
      self.amount = amount
      self.currencyCode = currencyCode
    }

    public let amount: Double
    public let currencyCode: String
  }
}
