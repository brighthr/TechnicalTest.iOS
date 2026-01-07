//  Copyright © 2025 BrightHR. All rights reserved.

import ComposableArchitecture
import SwiftUI

struct ScreenC: View {
  let store: StoreOf<ScreenCLogic>
  var body: some View {
    VStack(spacing: 10) {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("ScreenC")

      VStack(spacing: 10) {
        Spacer()
        Button {
          // TODO:
        } label: {
          Text("Pop to root")
        }
      }
    }
    .padding()
  }
}

#Preview {
  ScreenC(store: Store(
    initialState: ScreenCLogic.State(),
    reducer: { ScreenCLogic() }
  ))
}
