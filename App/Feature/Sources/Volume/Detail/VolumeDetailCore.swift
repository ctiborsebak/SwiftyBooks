import ComposableArchitecture
import Domain
import Foundation
import Shared

extension VolumeDetailFeature {
  @Reducer
  public enum Destination {
    @ReducerCaseIgnored
    case website(IdentifiableURL)
  }
}
extension VolumeDetailFeature.Destination.State: Equatable {}

@Reducer
public struct VolumeDetailFeature {
  public init() {}

  // MARK: - State

  @ObservableState
  public struct State: Equatable {
    let volume: Volume
    @Presents var destination: Destination.State?

    public init(volume: Volume) {
      self.volume = volume
    }
  }

  // MARK: - Action

  @CasePathable
  public enum Action: ViewAction {
    case view(View)
    case destination(PresentationAction<Destination.Action>)

    @CasePathable
    public enum View {
      case buyNowTapped
      case backButtonTapped
    }
  }

  // MARK: - Reducer

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .view(viewAction):
        return reduce(into: &state, viewAction: viewAction)

      case .destination:
        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}

private extension VolumeDetailFeature {
  func reduce(into state: inout State, viewAction: Action.ViewAction) -> EffectOf<Self> {
    switch viewAction {
    case .buyNowTapped:
      guard
        let urlString = state.volume.buyLink,
        let sourceURL = URL(string: urlString)
      else {
        return .none
      }

      state.destination = .website(.init(sourceURL))

      return .none

    case .backButtonTapped:
      @Dependency(\.dismiss) var dismiss

      return .run { _ in await dismiss() }
    }
  }
}
