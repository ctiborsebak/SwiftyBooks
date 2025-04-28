import ComposableArchitecture
import SwiftUI
import Theme
import Volume

public extension LibraryFeature {
  @ViewAction(for: LibraryFeature.self)
  struct MainView: View {

    // MARK: - Properties

    @Bindable public var store: StoreOf<LibraryFeature>
    @FocusState var isSearching
    @SwiftUI.State private var isShowingSearchbar = true

    public init(store: StoreOf<LibraryFeature>) {
      self.store = store
    }

    // MARK: - Body

    public var body: some View {
      ZStack {
        VStack(spacing: .zero) {
          if isShowingSearchbar {
            // TODO: Extract into a separate search feature
            HStack {
              TextField(
                "Search books...",
                text: $store.searchText.sending(\.view.searchTextChanged)
              )
              .focused($isSearching)
              .foregroundStyle(Color.Text.primary)
              .font(.system(.title2))

              Spacer()
            }
            .padding(.Spacing.S)
            .background {
              RoundedRectangle(cornerSize: .init(width: .CornerRadius.S, height: .CornerRadius.S))
                .stroke(lineWidth: .Width.line)
                .foregroundStyle(isSearching ? Color.Accent.primary : Color.Neutral.primary)
            }
            .padding(.top, .Spacing.L)
            .padding(.horizontal, .Spacing.S)
          }

          if store.isShowingStartMessage {
            StartBySearchingView()
          }

          if store.isShowingError {
            SearchErrorView { send(.retryTapped) }
          }

          if store.noItemsFound {
            NoItemsFoundView()
          }

          PlainList(spacing: .Spacing.XS,padding: .Spacing.S) {
            Group {
              ForEach(store.scope(state: \.volumeCards, action: \.volumeCard)) { store in
                VolumeCardFeature.MainView(store: store)
              }

              if !store.isActivityIndicatorHidden {
                ActivityIndicator()
                  .onAppear {
                    if store.shownItemsCount > 0 {
                      send(.paginationLoading)
                    }
                  }
                  .centerHorizontally()
                  .padding(.vertical, .Spacing.S)
              }
            }
          }
          .simultaneousGesture(
            DragGesture()
              .onChanged { value in
                withAnimation(.spring(duration: 0.3)) {
                  let verticalMovement = value.translation.height

                  if verticalMovement < 0,
                     store.shownItemsCount > 0 {
                    isShowingSearchbar = false
                  } else {
                    isShowingSearchbar = true
                  }
                }
              }
          )
        }

        if isSearching {
          DismissKeyboardOverlayView { isSearching = false }
        }
      }
      .background(Color.Background.primary)
      // NOTE: Navigation destination has to live in this feature, rather than the `VolumeCardFeature` (which would be a more appropriate place), because all the cards are embedded inside a list and using `.navigationDestination` on lazy views (such as `List`) is a bad practise and such navigation destinations will be ignored by the navigation stack in the future versions of Swift / Xcode
      .navigationDestination(
        item: $store.scope(state: \.destination?.detail,action: \.destination.detail)
      ) {
        store in
        VolumeDetailFeature.MainView(store: store)
      }
    }
  }
}

private extension LibraryFeature {
  struct StartBySearchingView: View {
    var body: some View {
      VStack {
        Spacer()

        Text("Start by searching")
          .font(.system(.title3))
          .foregroundStyle(Color.Text.primary)

        Spacer()
      }
    }
  }

  struct NoItemsFoundView: View {
    var body: some View {
      VStack {
        Spacer()

        Text("No items found, try another query.")
          .font(.system(.title3))
          .foregroundStyle(Color.Text.primary)

        Spacer()
      }
    }
  }

  struct SearchErrorView: View {
    let retry: () -> Void

    var body: some View {
      VStack(spacing: .Spacing.S) {
        Spacer()

        Text("Something went wrong, please try searching again.")
          .font(.system(.title3))
          .foregroundStyle(Color.Text.primary)

        RaisedButton(
          caption: "Retry",
          action: retry
        )

        Spacer()
      }
    }
  }

  struct DismissKeyboardOverlayView: View {
    let changeFocusState: () -> Void

    var body: some View {
      Color.clear
        .contentShape(Rectangle())
        .onTapGesture {
          changeFocusState()
        }
        .simultaneousGesture(
          DragGesture()
            .onChanged { _ in
              changeFocusState()
            }
        )
        .ignoresSafeArea()
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
