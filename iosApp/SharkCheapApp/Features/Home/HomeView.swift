//
//  HomeView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    private static let maxStoreDealsDisplayCount = 8

    let store: StoreOf<HomeFeature>

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                navigationBar
                scrollContent
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Asset.contentBackground.swiftUIColor)
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: SafariDestination.self) { destination in
                DealWebScreen(url: destination.url)
            }
            .onAppear {
                store.send(.onAppear)
            }
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
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                if let loadError = store.loadError {
                    Text(loadError)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }

                todaysDealsSection
                storeDealsSection
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
    }

    private var todaysDealsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            LargeSectionTitleLabel(text: L10n.TodaysDeal.title)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(store.todaysDeals) { deal in
                        if let destination = deal.safariDestination {
                            NavigationLink(value: destination) {
                                HomeTodaysDealThumbView(
                                    imageURL: URL(string: deal.thumbnailUrl),
                                    storeId: deal.storeId,
                                    discountRate: deal.discountRate,
                                    salePrice: deal.salePrice,
                                    normalPrice: deal.normalPrice
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }

    private var storeDealsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            LargeSectionTitleLabel(text: L10n.StoreDeal.title)

            if let storeDealsLoadError = store.storeDealsLoadError {
                Text(storeDealsLoadError)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .padding(.top, 8)
            }

            VStack(alignment: .leading, spacing: 24) {
                ForEach(store.storeDealSections) { section in
                    VStack(alignment: .leading, spacing: 12) {
                        MiddleSectionTitleLabel(
                            title: section.storeName,
                            storeId: section.id,
                            logoURL: URL(string: section.logoUrl)
                        )
                        storeDealHorizontalList(deals: section.deals, storeId: section.id)
                    }
                }
            }
            .padding(.top, 8)
        }
    }

    private func storeDealHorizontalList(deals: [DealItem], storeId: String) -> some View {
        let displayedDeals = Array(deals.prefix(Self.maxStoreDealsDisplayCount))
        let showsSeeMore = deals.count > Self.maxStoreDealsDisplayCount

        return ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(displayedDeals) { deal in
                    if let destination = deal.safariDestination {
                        NavigationLink(value: destination) {
                            StoreDealThumbView(
                                imageURL: URL(string: deal.thumbnailUrl),
                                discountRate: deal.discountRate,
                                salePrice: deal.salePrice,
                                normalPrice: deal.normalPrice
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }

                if showsSeeMore {
                    StoreDealSeeMoreCell(storeId: storeId)
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
