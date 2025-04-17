//  Copyright © 2025 BrightHR. All rights reserved.

import ComposableArchitecture
import SwiftUI

struct ScreenB: View {
  let store: StoreOf<ScreenBLogic>
  var body: some View {
    VStack(spacing: 10) {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("ScreenB")

      VStack(spacing: 10) {
        Spacer()
        Button {
          // TODO:
        } label: {
          Text("Navigate to A then C")
        }
      }
    }
    .padding()
  }
}

#Preview {
  ScreenB(store: Store(
    initialState: ScreenBLogic.State(),
    reducer: { ScreenBLogic() }
  ))
}
