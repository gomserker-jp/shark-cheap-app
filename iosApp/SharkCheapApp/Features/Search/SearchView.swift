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
            content
                .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var content: some View {
        VStack(spacing: 0) {
            navigationBar
            searchBar
            CommonSpacer()
            resultsSection
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Asset.contentBackground.swiftUIColor)
    }

    private var searchBar: some View {
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
    }

    private var resultsSection: some View {
        ZStack {
            resultsList

            if store.isLoading {
                ProgressView()
            }
        }
    }

    private var resultsList: some View {
        List {
            if let loadError = store.loadError {
                Text(loadError)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .listRowSeparator(.hidden)
            }

            ForEach(Array(store.results.enumerated()), id: \.element.id) { index, result in
                searchResultRow(result: result, index: index)
            }
        }
        .listStyle(.plain)
        .listSectionSpacing(0)
        .environment(\.defaultMinListRowHeight, 0)
        .contentMargins(.bottom, 24, for: .scrollContent)
    }

    private func searchResultRow(result: GameSearchResultItem, index: Int) -> some View {
        ZStack {
            SearchListCellView(
                gameId: result.id,
                external: result.title,
                thumb: result.thumbnailURL,
                showsTopBorder: index == 0
            )

            NavigationLink {
                GameDetailView(
                    gameId: result.id,
                    title: result.title,
                    thumb: result.thumbnailURL,
                    salePrice: 7.49,
                    normalPrice: 14.99,
                    cheapestPriceEverPrice: 3.99
                )
            } label: {
                EmptyView()
            }
            .opacity(0)
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
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
