//
//  SearchView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import ComposableArchitecture
import SwiftUI

struct SearchView: View {
    let store: StoreOf<SearchFeature>

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                navigationBar

                SearchBarView(
                    text: Binding(
                        get: { store.searchText },
                        set: { store.send(.searchTextChanged($0)) }
                    ),
                    placeholder: L10n.Search.placeholder,
                    onSubmit: { store.send(.searchSubmitted) },
                    onClear: { store.send(.searchTextCleared) }
                )
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

                Color.gray.opacity(0.25)
                    .frame(height: 8)

                ZStack {
                    List {
                        if let loadError = store.loadError {
                            Text(loadError)
                                .font(.footnote)
                                .foregroundStyle(.red)
                                .listRowSeparator(.hidden)
                        }

                        ForEach(Array(store.results.enumerated()), id: \.element.id) { index, result in
                            SearchListCellView(
                                gameId: result.id,
                                external: result.title,
                                thumb: result.thumbnailURL,
                                showsTopBorder: index == 0
                            )
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                    .listSectionSpacing(0)
                    .environment(\.defaultMinListRowHeight, 0)
                    .ignoresSafeArea(edges: .bottom)
                    .padding(.bottom, 24)

                    if store.isLoading {
                        ProgressView()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Asset.contentBackground.swiftUIColor)
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var navigationBar: some View {
        HStack {
            Spacer()

            Image(asset: Asset.appLogo)
                .resizable()
                .scaledToFit()
                .frame(height: 32)

            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
    }
}

#Preview {
    SearchView(
        store: Store(initialState: SearchFeature.State()) {
            SearchFeature()
        } withDependencies: {
            $0.cheapSharkClient = .previewValue
        }
    )
}
