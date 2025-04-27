import ComposableArchitecture
import Domain
import Extensions
import SwiftUI
import Theme

public extension VolumeCardFeature {
  @ViewAction(for: VolumeCardFeature.self)
  struct MainView: View {

    // MARK: - Properties

    @Bindable public var store: StoreOf<VolumeCardFeature>

    public init(store: StoreOf<VolumeCardFeature>) {
      self.store = store
    }

    // MARK: - Body

    public var body: some View {
      Button {
        send(.itemTapped)
      } label: {
        VStack(alignment: .leading, spacing: .Spacing.XS) {
          HStack(alignment: .top) {
            Text(store.volume.authors.joined(separator:", "))
              .lineLimit(1)
              .font(.system(.caption))
              .foregroundStyle(Color.Text.primary)

            Spacer()

            if let year = store.volume.publishedYear {
              Text(year)
                .font(.caption2)
                .foregroundStyle(Color.Text.primary)
            }
          }

          Divider()
            .foregroundStyle(Color.Neutral.primary)

          HStack(alignment: .top, spacing: .zero) {
            AsyncImage(url: .init(string: store.volume.thumbnailImageURLPath?.secureURL ?? "")) { image in
              image.resizable()
                .scaledToFit()
                .cornerRadius(.CornerRadius.S)
                .clipped()
            } placeholder: {
              BookImagePlaceholderView()
            }

            VStack(alignment: .leading) {
              Text(store.volume.title)
                .lineLimit(3)
                .font(.system(.caption))
                .foregroundStyle(Color.Text.primary)

              if let description = store.volume.description {
                Text(description)
                  .multilineTextAlignment(.leading)
                  .font(.caption2) 
                  .foregroundStyle(Color.Text.secondary)
                  .padding(.top, .Spacing.XXXS)
              }

              Spacer()

              HStack {
                Spacer()

                if let price = store.volume.price {
                  BadgeView(
                    caption: String(format: "%.2f %@", price.amount, price.currencyCode),
                    color: Color.Text.secondary
                  )
                }

                if let isMatureContent = store.volume.isMatureContent {
                  MatureWarningBadgeView(isMatureContent: isMatureContent)
                }

                if let saleability = store.volume.saleability {
                  SaleabilityBadgeView(saleability: saleability)

                }
              }
              .padding(.top, .Spacing.XXXS)
            }
            .padding(.leading, .Spacing.XS)
          }
        }
        .frame(height: 150)
        .padding(.Spacing.S)
        .background {
          Color.Background.card
            .cornerRadius(.CornerRadius.S)
        }
      }
    }
  }
}

#if DEBUG
#Preview("Plain") {
  VolumeCardFeature.MainView(
    store: .init(
      initialState: VolumeCardFeature.State(
        volume: .init(
          id: "id",
          title: "Flower Arranging for the First Time",
          authors: [
            "Ruby Begonia"
          ],
          description: "Even if you've never made a flower arrangement before, you can do it beautifully the first time with these simple, professional techniques. A host of fresh, dried, or silk flower designs parade across the pages in lavish photos, and the detailed question and answer format shows how to realize them.",
          thumbnailImageURLPath: "https://books.google.com/books/content?id=gzAg7NqVJoAC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",
          isMatureContent: true,
          publishedYear: "2003",
          saleability: .preorder,
          price: .init(amount: 146.55, currencyCode: "CZK")
        )
      ),
      reducer: VolumeCardFeature.init
    )
  )
}

#Preview("Missing fields") {
  VolumeCardFeature.MainView(
    store: .init(
      initialState: VolumeCardFeature.State(
        volume: .init(
          id: "id",
          title: "Flower Arranging for the First Time",
          authors: [
            "Ruby Begonia"
          ],
          description: nil,
          thumbnailImageURLPath: nil,
          isMatureContent: nil,
          publishedYear: nil,
          saleability: nil,
          price: nil
        )
      ),
      reducer: VolumeCardFeature.init
    )
  )
}
#endif
