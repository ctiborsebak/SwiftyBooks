import ComposableArchitecture
import Domain
import Testing

@testable import Volume

struct VolumeDetailCoreTests {
  @Test
  func sut_should_dismiss() async {
    await confirmation { confirmation in
      let state = makeVolumeDetailState()

      let store = await TestStore(
        initialState: state,
        reducer: VolumeDetailFeature.init
      ) { dependencies in
        dependencies.dismiss = .init{
          confirmation.confirm()
        }
      }

      await store.send(\.view.backButtonTapped)
    }
  }

  @Test
  func sut_should_present_website_upon_buy_now_tap() async throws {
    let state = makeVolumeDetailState(
      volume: .mock(buyLink: "https://play.google.com/books/Harry-Potter")
    )

    let store = await TestStore(
      initialState: state,
      reducer: VolumeDetailFeature.init
    )

    await store.send(\.view.buyNowTapped) { state in
      state.destination = .website(.init(try #require(.init(string: "https://play.google.com/books/Harry-Potter"))))
    }
  }
}

// MARK: - Helpers

private func makeVolumeDetailState(
  volume: Volume = .mock()
) -> VolumeDetailFeature.State {
  .init(volume: volume)
}
