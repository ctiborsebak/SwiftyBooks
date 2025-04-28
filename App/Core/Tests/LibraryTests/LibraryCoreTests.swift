import ComposableArchitecture
import Domain
import Shared
import Testing

@testable import Library

struct LibraryCoreTests {
  @Test
  func sut_should_not_fetch_books_when_search_query_is_empty() async {
    let state = makeLibraryFeatureState()
    
    let store = await TestStore(
      initialState: state,
      reducer: LibraryFeature.init
    )

    await store.send(\.view.searchTextChanged, "")
  }

  @Test
  func sut_should_not_fetch_books_when_query_didnt_change() async {
    var state = makeLibraryFeatureState()
    state.searchText = "Harry Potter"

    let store = await TestStore(
      initialState: state,
      reducer: LibraryFeature.init
    )

    await store.send(\.view.searchTextChanged, "Harry Potter")
  }

  @Test
  func sut_should_reset_state_and_fetch_books_when_query_is_valid() async {
    let clock = TestClock()
    var state = makeLibraryFeatureState()
    state.searchText = "Harry Potter"
    state.isActivityIndicatorHidden = true
    state.volumeCards = [.init(volume: .mock())]
    state.shownItemsCount = 1
    state.isShowingStartMessage = false
    state.noItemsFound = true

    let store = await TestStore(
      initialState: state,
      reducer: LibraryFeature.init
    ) { dependencies in
      dependencies.googleBooksClient.search = { query, index in
        return .success(
          .init(
            volumes: [.mock()],
            totalItems: 1
          )
        )
      }
      dependencies.continuousClock = clock
    }

    let task = await store.send(\.view.searchTextChanged, "Nineteen Eighty-Four") { state in
      state.searchText = "Nineteen Eighty-Four"
      state.isActivityIndicatorHidden = false
      state.shownItemsCount = 0
      state.volumeCards = []
      state.noItemsFound = false
    }
    await clock.advance(by: .seconds(2))
    await store.receive(\.debouncedTextChanged, "Nineteen Eighty-Four")
    await store.receive(\.volumesResultChanged, .success(.init(volumes: [.mock()], totalItems: 1))) { state in
      state.volumeCards = [.init(volume: .mock())]
      state.shownItemsCount = 1
      state.isActivityIndicatorHidden = true
    }
    await task.cancel()
  }

  @Test
  func sut_should_display_error_message_when_fetching_books_fails_and_no_items_are_displayed() async {
    let clock = TestClock()
    let state = makeLibraryFeatureState()

    let store = await TestStore(
      initialState: state,
      reducer: LibraryFeature.init
    ) { dependencies in
      dependencies.googleBooksClient.search = { _, _ in
          .failure(.decodingFailed)
      }
      dependencies.continuousClock = clock
    }

    let task = await store.send(\.view.searchTextChanged, "Nineteen Eighty-Four") { state in
      state.searchText = "Nineteen Eighty-Four"
      state.isActivityIndicatorHidden = false
      state.isShowingStartMessage = false
    }
    await clock.advance(by: .seconds(2))
    await store.receive(\.debouncedTextChanged, "Nineteen Eighty-Four")
    await store.receive(\.volumesResultChanged, .failure(.decodingFailed)) { state in
      state.isActivityIndicatorHidden = true
      state.isShowingError = true
    }
    await task.cancel()
  }

  @Test
  func sut_should_show_no_items_found_when_zero_results_returned() async {
    var state = makeLibraryFeatureState()
    state.searchText = "Harry Potter"

    let store = await TestStore(
      initialState: state,
      reducer: LibraryFeature.init
    )

    await store.send(\.volumesResultChanged, .success(.init(volumes: [], totalItems: 0))) { state in
      state.noItemsFound = true
    }
  }

  @Test
  func sut_should_fetch_books_when_paginating() async {
    var state = makeLibraryFeatureState()
    state.searchText = "Harry Potter"

    let store = await TestStore(
      initialState: state,
      reducer: LibraryFeature.init
    ) { dependencies in
      dependencies.googleBooksClient.search = { _, _ in
          .success(.init(volumes: [], totalItems: 0))
      }
    }

    await store.send(\.view.paginationLoading)
    await store.receive(\.volumesResultChanged, .success(.init(volumes: [], totalItems: 0))) { state in
      state.noItemsFound = true
    }
  }

  @Test
  func sut_should_fetch_books_upon_retry_tap() async {
    var state = makeLibraryFeatureState()
    state.searchText = "Harry Potter"

    let store = await TestStore(
      initialState: state,
      reducer: LibraryFeature.init
    ) { dependencies in
      dependencies.googleBooksClient.search = { _, _ in
          .success(.init(volumes: [], totalItems: 0))
      }
    }

    await store.send(\.view.retryTapped) { state in
      state.isActivityIndicatorHidden = false
    }
    await store.receive(\.volumesResultChanged, .success(.init(volumes: [], totalItems: 0))) { state in
      state.isActivityIndicatorHidden = true
      state.noItemsFound = true
    }
  }

  @Test
  func sut_should_navigate_to_volume_detail() async {
    var state = makeLibraryFeatureState()
    state.destination = nil
    state.volumeCards = .init(uniqueElements: [.init(volume: .mock(id: "mockID"))])

    let store = await TestStore(
      initialState: state,
      reducer: LibraryFeature.init
    )

    await store.send(.volumeCard(.element(id: "mockID", action: .delegate(.itemTapped)))) { state in
      state.destination = .detail(.init(volume: .mock(id: "mockID")))
    }
  }
}

// MARK: - Helpers

private func makeLibraryFeatureState() -> LibraryFeature.State {
  .init()
}
