//
//  AppFeature.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import ComposableArchitecture

enum AppPhase: Equatable {
    case splash
    case home
}

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var phase: AppPhase = .splash
        var splash = SplashFeature.State()
        var home = HomeFeature.State()
    }

    enum Action: Equatable {
        case splash(SplashFeature.Action)
        case home(HomeFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.splash, action: \.splash) {
            SplashFeature()
        }
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        Reduce { state, action in
            switch action {
            case .splash(.splashDelayFinished):
                state.phase = .home
                return .none

            case .splash, .home:
                return .none
            }
        }
    }
}
