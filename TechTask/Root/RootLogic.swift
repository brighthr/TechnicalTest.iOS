//  Copyright © 2025 BrightHR. All rights reserved.

import ComposableArchitecture

@Reducer
struct RootLogic: Reducer {
  @ObservableState
  struct State: Equatable {}

  enum Action {}

  var body: some ReducerOf<Self> {
    Reduce<State, Action> { _, _ in
      .none
    }
  }
}
