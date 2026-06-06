//
//  AppFeature.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import ComposableArchitecture

enum AppPhase: Equatable {
    case splash
    case main
}

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var phase: AppPhase = .splash
        var splash = SplashFeature.State()
        var tab = TabFeature.State()
    }

    enum Action: Equatable {
        case splash(SplashFeature.Action)
        case tab(TabFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.splash, action: \.splash) {
            SplashFeature()
        }
        Scope(state: \.tab, action: \.tab) {
            TabFeature()
        }
        Reduce { state, action in
            switch action {
            case .splash(.splashDelayFinished):
                state.phase = .main
                return .none

            case .splash, .tab:
                return .none
            }
        }
    }
}
