//
//  TabFeature.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import ComposableArchitecture

enum MainTab: Equatable {
    case home
    case search
    case favorites
}

@Reducer
struct TabFeature {
    @ObservableState
    struct State: Equatable {
        var selectedTab: MainTab = .home
        var home = HomeFeature.State()
    }

    enum Action: Equatable {
        case tabSelected(MainTab)
        case home(HomeFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        Reduce { state, action in
            switch action {
            case let .tabSelected(tab):
                state.selectedTab = tab
                return .none

            case .home:
                return .none
            }
        }
    }
}
