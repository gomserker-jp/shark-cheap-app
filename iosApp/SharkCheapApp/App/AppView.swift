//
//  AppView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
    let store: StoreOf<AppFeature>

    var body: some View {
        switch store.phase {
        case .splash:
            SplashView(
                store: store.scope(state: \.splash, action: \.splash)
            )

        case .main:
            AppTabView(
                store: store.scope(state: \.tab, action: \.tab)
            )
        }
    }
}

#Preview {
    AppView(
        store: Store(initialState: AppFeature.State()) {
            AppFeature()
        } withDependencies: {
            $0.cheapSharkClient = .previewValue
        }
    )
}
