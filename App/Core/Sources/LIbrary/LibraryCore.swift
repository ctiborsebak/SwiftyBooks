import ComposableArchitecture
import Domain
import GoogleBooksClient
import IdentifiedCollections
import Networking
import Volume

// MARK: - Destination

extension LibraryFeature {
  @Reducer
  public enum Destination {
    case detail(VolumeDetailFeature)
  }
}
extension LibraryFeature.Destination.State: Equatable {}

@Reducer
public struct LibraryFeature {
  public init() {}

  // MARK: - State

  @ObservableState
  public struct State: Equatable {
    @Presents var destination: Destination.State?
    var searchText: String = ""
    var shownItemsCount: Int = 0
    var isShowingError: Bool = false
    var isActivityIndicatorHidden: Bool = true
    var isShowingStartMessage: Bool = true
    var noItemsFound: Bool = false

    var volumeCards: IdentifiedArrayOf<VolumeCardFeature.State> = []

    public init() {}
  }

  // MARK: - Action

  @CasePathable
  public enum Action: ViewAction {
    case view(View)
    case destination(PresentationAction<Destination.Action>)
    case debouncedTextChanged(String)
    case volumesResultChanged(Result<Volumes, NetworkError>)

    case volumeCard(IdentifiedActionOf<VolumeCardFeature>)

    @CasePathable
    public enum View {
      case searchTextChanged(String)
      case paginationLoading
      case retryTapped
    }
  }

  // MARK: - Reducer

  enum CancelID {
    case debounce
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .view(viewAction):
        return reduce(into: &state, viewAction: viewAction)
        
      case let .debouncedTextChanged(searchQuery):
        return fetchBooks(searchQuery: searchQuery, state: &state)

      case let .volumesResultChanged(volumesResult):
        switch volumesResult {
        case let .success(volumes):
          guard !volumes.volumes.isEmpty else {
            state.noItemsFound = true
            state.isActivityIndicatorHidden = true
            return .none
          }

          state.volumeCards.append(
            contentsOf: IdentifiedArray(
              uniqueElements: volumes.volumes.map(VolumeCardFeature.State.init)
            )
          )
          state.shownItemsCount += volumes.volumes.count
          state.isActivityIndicatorHidden = state.shownItemsCount >= volumes.totalItems
          state.isShowingError = false

        case .failure:
          if state.shownItemsCount == 0 {
            state.isShowingError = true
            state.isActivityIndicatorHidden = true
          }
        }

        return .none

      case let .volumeCard(.element(id, .delegate(.itemTapped))):
        guard let volume = state.volumeCards.first(where: { $0.id == id } )?.volume else {
          return .none
        }

        state.destination = .detail(.init(volume: volume))

        return .none

      case .volumeCard,
          .destination:
        return .none
      }
    }
    .forEach(\.volumeCards, action: \.volumeCard) {
      VolumeCardFeature()
    }
    .ifLet(\.$destination, action: \.destination)
  }
}

private extension LibraryFeature {
  func reduce(into state: inout State, viewAction: Action.ViewAction) -> EffectOf<Self> {
    switch viewAction {
    case let .searchTextChanged(searchQuery):
      guard searchQuery != state.searchText else {
        return .none
      }
      
      resetForNewSearch(state: &state)
      state.searchText = searchQuery

      guard !searchQuery.isEmpty else {
        state.isShowingStartMessage = true
        state.isActivityIndicatorHidden = true
        return .none
      }

      return .run { send in
        @Dependency(\.continuousClock) var continuousClock

        try await continuousClock.sleep(for: .seconds(1))
        await send(.debouncedTextChanged(searchQuery))
      }
      .cancellable(id: CancelID.debounce, cancelInFlight: true)

    case .paginationLoading:
      return fetchBooks(searchQuery: state.searchText, state: &state)

    case .retryTapped:
      state.isShowingError = false
      state.isActivityIndicatorHidden = false
      return fetchBooks(searchQuery: state.searchText, state: &state)
    }
  }

  func fetchBooks(searchQuery: String, state: inout State) -> EffectOf<Self> {
    return .run(priority: .background) { [currentIndex = state.shownItemsCount] send in
      @Dependency(\.googleBooksClient) var googleBooksClient

      let lastItemIndex = currentIndex > 0 ? currentIndex - 1 : 0

      let volumes = await googleBooksClient.search(searchQuery, lastItemIndex)
      await send(.volumesResultChanged(volumes))
    }
  }

  func resetForNewSearch(state: inout State) {
    state.isShowingStartMessage = false
    state.isActivityIndicatorHidden = false
    state.volumeCards = []
    state.shownItemsCount = 0
    state.isShowingError = false
    state.noItemsFound = false
  }
}
