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
    case storesResponse(StoresRequestResult)

    enum StoresRequestResult: Equatable {
      case success([StoreItem])
      case failure(String)
    }
  }

  @Dependency(\.cheapSharkClient) var cheapSharkClient

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.displayState = .loading
        state.loadError = nil
        return .run { send in
          do {
            let stores = try await cheapSharkClient.fetchStores()
            await send(.storesResponse(.success(stores)))
          } catch {
            await send(.storesResponse(.failure(error.localizedDescription)))
          }
        }

      case let .storesResponse(.success(stores)):
        state.stores = stores
        state.loadError = nil
        state.displayState = .loadingCompleted
        return .none

      case let .storesResponse(.failure(message)):
        state.loadError = message
        state.displayState = .loadingCompleted
        return .none
      }
    }
  }
}
