import SwiftUI

private struct NavigationBarViewModifier: ViewModifier {
  let title: String
  let titleDisplayMode: NavigationBarItem.TitleDisplayMode
  let backButtonAction: () -> Void

  init(
    title: String,
    titleDisplayMode: NavigationBarItem.TitleDisplayMode = .inline,
    backButtonAction: @escaping () -> Void,
  ) {
    self.title = title
    self.titleDisplayMode = titleDisplayMode
    self.backButtonAction = backButtonAction
  }

  func body(content: Content) -> some View {
    content
      .navigationTitle(title)
      .navigationBarTitleDisplayMode(titleDisplayMode)
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button(
            action: {
              backButtonAction()
            },
            label: {
              Image(systemName: "chevron.left")
                .foregroundColor(Color.Accent.primary)
            }
          )
        }
      }
  }
}

public extension View {
  func backNavigationBar(
    title: String,
    titleDisplayMode: NavigationBarItem.TitleDisplayMode = .inline,
    backButtonAction: @escaping () -> Void
  ) -> some View {
    modifier(
      NavigationBarViewModifier(
        title: title,
        titleDisplayMode: titleDisplayMode,
        backButtonAction: backButtonAction
      )
    )
  }
}
