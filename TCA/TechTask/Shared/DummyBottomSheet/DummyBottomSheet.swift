//  Copyright © 2025 BrightHR. All rights reserved.

import ComposableArchitecture
import SwiftUI

struct DummyBottomSheet: View {
  let store: StoreOf<DummyBottomSheetLogic>
  var body: some View {
    VStack(spacing: 10) {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("DummyBottomSheet")
    }
    .padding()
  }
}

#Preview {
  DummyBottomSheet(store: Store(
    initialState: DummyBottomSheetLogic.State(),
    reducer: { DummyBottomSheetLogic() }
  ))
}
