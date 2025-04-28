import ComposableArchitecture
import Domain
import SwiftUI
import Theme

extension VolumeDetailFeature {
  @ViewAction(for: VolumeDetailFeature.self)
  public struct MainView: View {

    // MARK: - Properties

    @Bindable public var store: StoreOf<VolumeDetailFeature>

    public init(store: StoreOf<VolumeDetailFeature>) {
      self.store = store
    }

    // MARK: - Body

    public var body: some View {
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading, spacing: .zero) {
          Group {
            AsyncImage(url: .init(string: store.volume.thumbnailImageURLPath?.secureURL ?? "")) { image in
              image.resizable()
                .scaledToFit()
                .cornerRadius(.CornerRadius.S)
                .clipped()
            } placeholder: {
              BookImagePlaceholderView()
            }
            .frame(height: 180)
          }
          .centerHorizontally(alignment: .bottom)

          Divider()
            .foregroundStyle(Color.Neutral.primary)
            .padding(.top, .Spacing.S)

          VStack(alignment: .leading, spacing: .Spacing.S) {
            if let title = store.volume.title {
              TitleAndSubtitleView(
                title: "Full Title",
                subtitle: title
              )
            }

            if !store.volume.authors.isEmpty {
              TitleAndSubtitleView(
                title: "Authors",
                subtitle: store.volume.authors.joined(separator:", ")
              )
            }

            if let publishedDate = store.volume.publishedYear {
              TitleAndSubtitleView(
                title: "Published Date",
                subtitle: publishedDate
              )
            }

            if let description = store.volume.description {
              TitleAndSubtitleView(
                title: "Description",
                subtitle: description
              )
            }
          }
          .padding(.top, .Spacing.M)

          HStack(spacing: .Spacing.S) {
            if let isMatureContent = store.volume.isMatureContent {
              MatureWarningBadgeView(isMatureContent: isMatureContent)
            }

            if let saleability = store.volume.saleability {
              SaleabilityBadgeView(saleability: saleability)
            }

            if let price = store.volume.price {
              BadgeView(
                caption: String(format: "%.2f %@", price.amount, price.currencyCode),
                color: Color.Text.secondary
              )
            }
          }
          .centerHorizontally()
          .padding(.top, .Spacing.M)

          if store.volume.buyLink != nil {
            RaisedButton(
              caption: "Buy now",
              action: { send(.buyNowTapped) }
            )
            .centerHorizontally()
            .padding(.top, .Spacing.L)
          }
        }
      }
      .padding(.horizontal, .Spacing.S)
      .padding(.vertical, .Spacing.L)
      .background(Color.Background.primary)
      .backNavigationBar(
        title: store.volume.title ?? "",
        backButtonAction: { send(.backButtonTapped) }
      )
      .sheet(
        store: store.scope(state: \.$destination.website, action: \.destination.website),
        content: { store in
          SafariView(url: store.withState { $0.id} )
        }
      )
    }
  }
}

private extension VolumeDetailFeature {
  struct TitleAndSubtitleView: View {
    let title: String
    let subtitle: String

    var body: some View {
      VStack(alignment: .leading, spacing: .Spacing.XXS) {
        Text(title)
          .font(.system(.headline))
          .foregroundStyle(Color.Text.primary)

        Text(subtitle)
          .font(.system(.subheadline))
          .foregroundStyle(Color.Text.secondary)
      }
    }
  }
}

#if DEBUG
#Preview {
  VolumeDetailFeature.MainView(
    store: .init(
      initialState: .init(
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
          price: .init(amount: 146.55, currencyCode: "CZK"),
          buyLink: "https://play.google.com/store/books/details?id=tuLz4j8QMk8C&rdid=book-tuLz4j8QMk8C&rdot=1&source=gbs_api"
        )
      ),
      reducer: VolumeDetailFeature.init
    )
  )
}
#endif
