//
//  HomeView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
  @Bindable var store: StoreOf<HomeFeature>

  private let gridColumns = [
    GridItem(.adaptive(minimum: 96), spacing: 16),
  ]

  var body: some View {
    ZStack {
      switch store.displayState {
      case .loading:
        IndicatorView()

      case .loadingCompleted, .tapped:
        content
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onAppear {
      store.send(.onAppear)
    }
    .alert($store.scope(state: \.$alert, action: \.alert))
  }

  @ViewBuilder
  private var content: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        if let loadError = store.loadError {
          Text(loadError)
            .font(.footnote)
            .foregroundStyle(.red)
        }

        LazyVGrid(columns: gridColumns, spacing: 16) {
          ForEach(store.stores) { storeItem in
            Button {
              store.send(.storeIconTapped(storeItem))
            } label: {
              StoreLogoView(url: storeItem.logoUrl)
            }
            .buttonStyle(.plain)
          }
        }
      }
      .padding()
    }
  }
}

#Preview {
  HomeView(
    store: Store(initialState: HomeFeature.State(displayState: .loadingCompleted)) {
      HomeFeature()
    } withDependencies: {
      $0.cheapSharkClient = .previewValue
    }
  )
}
