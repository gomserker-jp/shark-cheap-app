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

  var body: some View {
    VStack(spacing: 0) {
      navigationBar
      scrollContent
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Asset.contentBackground.swiftUIColor)
    .onAppear {
      store.send(.onAppear)
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

  private var scrollContent: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        if let loadError = store.loadError {
          Text(loadError)
            .font(.footnote)
            .foregroundStyle(.red)
        }

        todaysDealsSection
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }

  private var todaysDealsSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      LargeSectionTitleLabel(text: "Today's Deals")

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 0) {
          ForEach(store.todaysDeals) { deal in
            HomeTodaysDealThumbView(
              imageURL: URL(string: deal.thumbnailUrl),
              discountRate: deal.discountRate
            )
          }
        }
      }
    }
  }
}

#Preview {
  HomeView(
    store: Store(initialState: HomeFeature.State()) {
      HomeFeature()
    } withDependencies: {
      $0.cheapSharkClient = .previewValue
    }
  )
}
