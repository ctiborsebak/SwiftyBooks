import Domain
import SwiftUI
import Testing

@testable import VolumeCard

@Suite
struct SaleabilityBadgeViewTests {
  @Test(
    arguments: zip(
      [
        Volume.Saleability.forSale,
        Volume.Saleability.free,
        Volume.Saleability.notForSale,
        Volume.Saleability.preorder
      ],
      [
        "For sale",
        "Free",
        "Not for sale",
        "Pre-order"
      ]
    )
  )
  func sut_should_set_correct_caption(saleability: Volume.Saleability, caption: String) {
    let sut = saleability.caption

    #expect(sut == caption)
  }

  @Test(
    arguments: zip(
      [
        Volume.Saleability.forSale,
        Volume.Saleability.free,
        Volume.Saleability.notForSale,
        Volume.Saleability.preorder
      ],
      [
        Color.Semantic.info,
        Color.Semantic.positive,
        Color.Semantic.negative,
        Color.Semantic.info
      ]
    )
  )
  func sut_should_set_correct_caption(saleability: Volume.Saleability, color: Color) {
    let sut = saleability.badgeColor

    #expect(sut == color)
  }
}
