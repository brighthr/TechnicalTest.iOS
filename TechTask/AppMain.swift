//  Copyright © 2025 BrightHR. All rights reserved.

import ComposableArchitecture
import SwiftUI

@main
struct AppMain: App {
  var body: some Scene {
    WindowGroup {
      Root(store: Store(
        initialState: RootLogic.State(),
        reducer: { RootLogic() }
      ))
    }
  }
}
