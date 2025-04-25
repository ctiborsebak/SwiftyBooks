import ComposableArchitecture
import SwiftUI
import Theme

public extension LibraryFeature {
  @ViewAction(for: LibraryFeature.self)
  struct MainView: View {

    // MARK: - Properties

    @Bindable public var store: StoreOf<LibraryFeature>

    public init(store: StoreOf<LibraryFeature>) {
      self.store = store
    }

    // MARK: - Body

    public var body: some View {
      VStack(spacing: .zero) {
        // TODO: Replace with a searchbar
        Rectangle()
          .foregroundStyle(.blue)
          .frame(height: 50)

        List {
          Rectangle()
            .listRowInsets(EdgeInsets())
        }
        .listStyle(.plain)
        .background(Color.mint)
        .padding(.top, .Spacing.S)
      }
      .background(Color.Background.primary)
    }
  }
}

#if DEBUG
#Preview {
  LibraryFeature.MainView(
    store: .init(
      initialState: .init(),
      reducer: LibraryFeature.init
    )
  )
}
#endif
