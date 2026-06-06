//
//  SplashFeature.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import ComposableArchitecture
import Foundation

enum SplashDisplayState: Equatable {
  case loading
  case splashAnimation
  case loadingCompleted
}

@Reducer
struct SplashFeature {
  @ObservableState
  struct State: Equatable {
    var displayState: SplashDisplayState = .loading
    var stores: [StoreItem] = []
    var loadError: String?
  }

  enum Action: Equatable {
    case onAppear
    case persistenceCompleted([StoreItem])
    case splashAnimationEnded
    case splashDelayFinished
    case loadFailed(String)
  }

  @Dependency(\.cheapSharkClient) var cheapSharkClient
  @Dependency(\.continuousClock) var clock

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.displayState = .loading
        state.loadError = nil
        return .run { send in
          do {
            let stores = try await cheapSharkClient.fetchStores()
            try await cheapSharkClient.saveStores(stores)
            await send(.persistenceCompleted(stores))
          } catch {
            await send(.loadFailed(error.localizedDescription))
          }
        }

      case let .persistenceCompleted(stores):
        state.stores = stores
        state.loadError = nil
        state.displayState = .splashAnimation
        return .none

      case .splashAnimationEnded:
        return .run { send in
          try await clock.sleep(for: .seconds(1.5))
          await send(.splashDelayFinished)
        }

      case .splashDelayFinished:
        state.displayState = .loadingCompleted
        return .none

      case let .loadFailed(message):
        state.loadError = message
        state.displayState = .loading
        return .none
      }
    }
  }
}
