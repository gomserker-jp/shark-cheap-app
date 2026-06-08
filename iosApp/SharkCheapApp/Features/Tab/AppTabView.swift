//
//  AppTabView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import ComposableArchitecture
import SwiftUI

struct AppTabView: View {
    let store: StoreOf<TabFeature>

    var body: some View {
        TabView(selection: Binding(
            get: { store.selectedTab },
            set: { store.send(.tabSelected($0)) }
        )) {
            HomeView(store: store.scope(state: \.home, action: \.home))
                .tabItem {
                    Label(L10n.Tab.Home.title, systemImage: L10n.Tab.Home.sficon)
                }
                .tag(MainTab.home)

            SearchView(store: store.scope(state: \.search, action: \.search))
                .tabItem {
                    Label(L10n.Tab.Search.title, systemImage: L10n.Tab.Search.sficon)
                }
                .tag(MainTab.search)

            tabPlaceholder
                .tabItem {
                    Label(L10n.Tab.Favorites.title, systemImage: L10n.Tab.Favorites.sficon)
                }
                .tag(MainTab.favorites)
        }
    }

    private var tabPlaceholder: some View {
        Color.clear
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Asset.contentBackground.swiftUIColor)
    }
}

#Preview {
    AppTabView(
        store: Store(initialState: TabFeature.State()) {
            TabFeature()
        } withDependencies: {
            $0.cheapSharkClient = .previewValue
        }
    )
}
