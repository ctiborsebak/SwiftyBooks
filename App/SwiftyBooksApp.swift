import Library
import SwiftUI

@main
struct SwiftyBooksApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        LibraryFeature.MainView(
          store: .init(
            initialState: LibraryFeature.State(),
            reducer: LibraryFeature.init
          )
        )
      }
    }
  }
}
