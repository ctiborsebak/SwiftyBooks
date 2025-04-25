import ComposableArchitecture

@Reducer
public struct LibraryFeature {
  public init() {}

  // MARK: - State

  @ObservableState
  public struct State: Equatable {

    public init() {}
  }

  // MARK: - Action

  @CasePathable
  public enum Action: ViewAction {
    case view(View)

    @CasePathable
    public enum View {

    }
  }

  // MARK: - Reducer

  public var body: some ReducerOf<Self> {
    EmptyReducer()
  }
}
