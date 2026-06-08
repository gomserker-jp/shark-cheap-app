//
//  SearchFeature.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import ComposableArchitecture
import Foundation

@Reducer
struct SearchFeature {
    @ObservableState
    struct State: Equatable {
        var searchText = ""
        var results: [GameSearchResultItem] = []
        var isLoading = false
        var loadError: String?
    }

    enum Action: Equatable {
        case searchTextChanged(String)
        case searchSubmitted
        case searchTextCleared
        case searchResponse(SearchRequestResult)

        enum SearchRequestResult: Equatable {
            case success([GameSearchResultItem])
            case failure(String)
        }
    }

    @Dependency(\.cheapSharkClient) var cheapSharkClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .searchTextChanged(text):
                state.searchText = text
                return .none

            case .searchSubmitted:
                let query = state.searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !query.isEmpty else {
                    state.results = []
                    state.loadError = nil
                    state.isLoading = false
                    return .none
                }

                state.isLoading = true
                state.loadError = nil
                return .run { send in
                    do {
                        let results = try await cheapSharkClient.searchGames(query)
                        await send(.searchResponse(.success(results)))
                    } catch {
                        await send(.searchResponse(.failure(error.localizedDescription)))
                    }
                }

            case .searchTextCleared:
                state.searchText = ""
                return .none

            case let .searchResponse(.success(results)):
                state.results = results
                state.loadError = nil
                state.isLoading = false
                return .none

            case let .searchResponse(.failure(message)):
                state.loadError = message
                state.isLoading = false
                return .none
            }
        }
    }
}
