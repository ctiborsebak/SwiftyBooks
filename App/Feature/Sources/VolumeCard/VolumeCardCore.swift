import ComposableArchitecture
import Domain

@Reducer
public struct VolumeCardFeature {
  public init() {}

  // MARK: - State

  @ObservableState
  public struct State: Equatable {
    let volume: Volume

    public init(volume: Volume) {
      self.volume = volume
    }
  }

  // MARK: - Action

  @CasePathable
  public enum Action: ViewAction {
    case view(View)

    @CasePathable
    public enum View {
      case itemTapped
    }
  }

  // MARK: - Reducer

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .view(viewAction):
        return reduce(into: &state, viewAction: viewAction)
      }
    }
  }
}

private extension VolumeCardFeature {
  func reduce(into state: inout State, viewAction: Action.ViewAction) -> Effect<Action> {
    switch viewAction {
    case .itemTapped:
      // TODO: Display book detail

      return .none
    }
  }
}
