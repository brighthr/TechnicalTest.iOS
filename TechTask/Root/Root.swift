//  Copyright © 2025 BrightHR. All rights reserved.

import ComposableArchitecture
import SwiftUI

struct Root: View {
  let store: StoreOf<RootLogic>
  var body: some View {
    VStack(spacing: 10) {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("RootView")

      VStack(spacing: 10) {
        Spacer()
        Button {
          // TODO:
        } label: {
          Text("Navigate to Screen A")
        }
        Button {
          // TODO:
        } label: {
          Text("Navigate to Screen B")
        }
        Button {
          // TODO:
        } label: {
          Text("Navigate to Screen C")
        }
      }
    }
    .padding()
  }
}

#Preview {
  Root(store: Store(
    initialState: RootLogic.State(),
    reducer: { RootLogic() }
  ))
}
