import Domain

public extension Volume {
  static func mock(
    id: String = "",
    title: String = "",
    authors: [String] = [],
    description: String? = nil,
    thumbnailImageURLPath: String? = nil,
    isMatureContent: Bool? = nil,
    publishedYear: String? = nil,
    saleability: Volume.Saleability? = nil,
    price: Volume.Price? = nil,
    buyLink: String? = nil
  ) -> Self {
    .init(
      id: id,
      title: title,
      authors: authors,
      description: description,
      thumbnailImageURLPath: thumbnailImageURLPath,
      isMatureContent: isMatureContent,
      publishedYear: publishedYear,
      saleability: saleability,
      price: price,
      buyLink: buyLink
    )
  }
}
