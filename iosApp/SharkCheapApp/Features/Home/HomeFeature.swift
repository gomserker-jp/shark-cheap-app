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
        var storeDealSections: [StoreDealsSectionItem] = []
        var loadError: String?
        var storeDealsLoadError: String?
    }

    enum Action: Equatable {
        case onAppear
        case todaysDealsResponse(TodaysDealsRequestResult)
        case storeDealsResponse(StoreDealsRequestResult)

        enum TodaysDealsRequestResult: Equatable {
            case success([DealItem])
            case failure(String)
        }

        enum StoreDealsRequestResult: Equatable {
            case success([StoreDealsSectionItem])
            case failure(String)
        }
    }

    @Dependency(\.cheapSharkClient) var cheapSharkClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.loadError = nil
                state.storeDealsLoadError = nil
                return .merge(
                    .run { send in
                        do {
                            let deals = try await cheapSharkClient.fetchTodaysSpecialDeals()
                            await send(.todaysDealsResponse(.success(deals)))
                        } catch {
                            await send(.todaysDealsResponse(.failure(error.localizedDescription)))
                        }
                    },
                    .run { send in
                        do {
                            let sections = try await cheapSharkClient.fetchStoreDealsSections()
                            await send(.storeDealsResponse(.success(sections)))
                        } catch {
                            await send(.storeDealsResponse(.failure(error.localizedDescription)))
                        }
                    }
                )

            case let .todaysDealsResponse(.success(deals)):
                state.todaysDeals = deals
                state.loadError = nil
                return .none

            case let .todaysDealsResponse(.failure(message)):
                state.loadError = message
                return .none

            case let .storeDealsResponse(.success(sections)):
                state.storeDealSections = sections
                state.storeDealsLoadError = nil
                return .none

            case let .storeDealsResponse(.failure(message)):
                state.storeDealsLoadError = message
                return .none
            }
        }
    }
}
