import ComposableArchitecture
import Domain

@Reducer
public struct VolumeCardFeature {
  public init() {}

  // MARK: - State

  @ObservableState
  public struct State: Equatable, Identifiable {
    public var id: String {
      volume.id
    }

    public var volume: Volume

    public init(volume: Volume) {
      self.volume = volume
    }
  }

  // MARK: - Action

  @CasePathable
  public enum Action: ViewAction {
    case view(View)
    case delegate(Delegate)

    @CasePathable
    public enum View {
      case itemTapped
    }

    @CasePathable
    public enum Delegate {
      case itemTapped
    }
  }

  // MARK: - Reducer

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .view(viewAction):
        return reduce(into: &state, viewAction: viewAction)

      case .delegate:
        return .none
      }
    }
  }
}

private extension VolumeCardFeature {
  func reduce(into state: inout State, viewAction: Action.ViewAction) -> EffectOf<Self> {
    switch viewAction {
    case .itemTapped:
      return .send(.delegate(.itemTapped))
    }
  }
}
