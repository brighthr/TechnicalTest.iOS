//  Copyright © 2025 BrightHR. All rights reserved.

import ComposableArchitecture
import SwiftUI

struct ScreenA: View {
  let store: StoreOf<ScreenALogic>
  var body: some View {
    VStack(spacing: 10) {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("ScreenA")

      VStack(spacing: 10) {
        Spacer()
        Button {
          // TODO:
        } label: {
          Text("Show confirmation dialog")
        }
        Button {
          // TODO:
        } label: {
          Text("Show alert")
        }
        Button {
          // TODO:
        } label: {
          Text("Show bottom sheet")
        }

        Button {
          // TODO:
        } label: {
          Text("Show full screen cover")
        }
      }
    }
    .padding()
  }
}

#Preview {
  ScreenA(store: Store(
    initialState: ScreenALogic.State(),
    reducer: { ScreenALogic() }
  ))
}
