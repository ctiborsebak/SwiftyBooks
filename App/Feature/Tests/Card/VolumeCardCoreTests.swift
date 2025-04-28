import ComposableArchitecture
import Testing

@testable import Volume


struct VolumeCardCoreTests {
  @Test
  func sut_should_send_delegate_action_when_item_tapped() async {
    let state = VolumeCardFeature.State(volume: .mock())

    let store = await TestStore(
      initialState: state,
      reducer: VolumeCardFeature.init
    )

    await store.send(\.view.itemTapped)
    await store.receive(\.delegate.itemTapped)
  }
}
