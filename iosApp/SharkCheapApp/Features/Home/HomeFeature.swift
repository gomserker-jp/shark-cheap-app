//
//  HomeFeature.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import ComposableArchitecture
import Foundation

@Reducer
struct HomeFeature {
  @ObservableState
  struct State: Equatable {
    var todaysDeals: [DealItem] = []
    var loadError: String?
  }

  enum Action: Equatable {
    case onAppear
    case todaysDealsResponse(TodaysDealsRequestResult)

    enum TodaysDealsRequestResult: Equatable {
      case success([DealItem])
      case failure(String)
    }
  }

  @Dependency(\.cheapSharkClient) var cheapSharkClient

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.loadError = nil
        return .run { send in
          do {
            let deals = try await cheapSharkClient.fetchTodaysSpecialDeals()
            await send(.todaysDealsResponse(.success(deals)))
          } catch {
            await send(.todaysDealsResponse(.failure(error.localizedDescription)))
          }
        }

      case let .todaysDealsResponse(.success(deals)):
        state.todaysDeals = deals
        state.loadError = nil
        return .none

      case let .todaysDealsResponse(.failure(message)):
        state.loadError = message
        return .none
      }
    }
  }
}
