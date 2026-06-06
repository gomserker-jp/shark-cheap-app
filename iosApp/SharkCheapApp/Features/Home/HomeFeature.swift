//
//  HomeFeature.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import ComposableArchitecture
import Foundation

enum HomeDisplayState: Equatable {
  case loading
  case loadingCompleted
  case tapped(storeName: String)
}

@Reducer
struct HomeFeature {
  @ObservableState
  struct State: Equatable {
    var displayState: HomeDisplayState = .loading
    var stores: [StoreItem] = []
    var loadError: String?
    @Presents var alert: AlertState<Action.Alert>?
  }

  enum Action: Equatable {
    case onAppear
    case storesResponse(StoresRequestResult)
    case storeIconTapped(StoreItem)
    case alert(PresentationAction<Alert>)

    enum StoresRequestResult: Equatable {
      case success([StoreItem])
      case failure(String)
    }

    enum Alert: Equatable {
      case dismiss
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

      case let .storeIconTapped(store):
        state.displayState = .tapped(storeName: store.name)
        state.alert = AlertState {
          TextState("Store")
        } actions: {
          ButtonState(action: .dismiss) {
            TextState("OK")
          }
        } message: {
          TextState(store.name)
        }
        return .none

      case .alert(.presented(.dismiss)):
        state.displayState = .loadingCompleted
        state.alert = nil
        return .none

      case .alert(.dismiss):
        state.displayState = .loadingCompleted
        return .none

      case .alert:
        return .none
      }
    }
    .ifLet(\.$alert, action: \.alert)
  }
}
