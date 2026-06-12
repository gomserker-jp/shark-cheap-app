//
//  CheapSharkClient.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import ComposableArchitecture
import Foundation
import SharedLogic

struct CheapSharkClient: Sendable {
    var fetchStores: @Sendable () async throws -> [StoreItem]
    var saveStores: @Sendable ([StoreItem]) async throws -> Void
    var fetchDeals: @Sendable (DealsQuery) async throws -> ([DealItem], totalPageCount: Int?)
    var fetchTodaysSpecialDeals: @Sendable () async throws -> [DealItem]
    var fetchStoreDealsSections: @Sendable () async throws -> [StoreDealsSectionItem]
    var searchGames: @Sendable (String) async throws -> [GameSearchResultItem]
    var fetchGameDetail: @Sendable (String) async throws -> GameDetailItem

    init(
        fetchStores: @escaping @Sendable () async throws -> [StoreItem] = { [] },
        saveStores: @escaping @Sendable ([StoreItem]) async throws -> Void = { _ in },
        fetchDeals: @escaping @Sendable (DealsQuery) async throws -> ([DealItem], totalPageCount: Int?) = { _ in
            ([], totalPageCount: nil)
        },
        fetchTodaysSpecialDeals: @escaping @Sendable () async throws -> [DealItem] = {
            []
        },
        fetchStoreDealsSections: @escaping @Sendable () async throws -> [StoreDealsSectionItem] = {
            []
        },
        searchGames: @escaping @Sendable (String) async throws -> [GameSearchResultItem] = { _ in
            []
        },
        fetchGameDetail: @escaping @Sendable (String) async throws -> GameDetailItem = { _ in
            GameDetailItem(
                detail: SharedLogic.GameDetail(
                    title: "",
                    steamAppId: nil,
                    thumbnailUrl: "",
                    cheapestPriceEverPrice: 0,
                    cheapestPriceEverDate: 0,
                    deals: []
                )
            )
        }
    ) {
        self.fetchStores = fetchStores
        self.saveStores = saveStores
        self.fetchDeals = fetchDeals
        self.fetchTodaysSpecialDeals = fetchTodaysSpecialDeals
        self.fetchStoreDealsSections = fetchStoreDealsSections
        self.searchGames = searchGames
        self.fetchGameDetail = fetchGameDetail
    }
}

extension CheapSharkClient: DependencyKey {
    static let testValue = CheapSharkClient()
    static let previewValue = CheapSharkClient(
        fetchStores: {
            [
                StoreItem(
                    id: "1",
                    name: "Steam",
                    isActive: true,
                    bannerUrl: "https://www.cheapshark.com/images/stores/banners/0.png",
                    logoUrl: "https://www.cheapshark.com/images/stores/logos/0.png",
                    iconUrl: "https://www.cheapshark.com/images/stores/icons/0.png"
                ),
            ]
        },
        fetchStoreDealsSections: {
            [
                StoreDealsSectionItem(
                    id: "1",
                    storeName: "Steam",
                    logoUrl: "https://www.cheapshark.com/images/stores/logos/0.png",
                    deals: [
                        DealItem(
                            deal: SharedLogic.Deal(
                                id: "preview-deal-1",
                                internalName: "CSGO",
                                gameId: "1",
                                storeId: "1",
                                title: "Counter-Strike: Global Offensive",
                                salePrice: 7.49,
                                normalPrice: 14.99,
                                savingsPercentage: 50,
                                isOnSale: true,
                                metacriticScore: 83,
                                steamRatingText: "Very Positive",
                                steamRatingPercent: 90,
                                steamRatingCount: 1000,
                                steamAppId: "730",
                                releaseDate: 1_000_000_000,
                                lastChange: 1_000_000_100,
                                dealRating: 8.5,
                                thumbnailUrl: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg",
                                metacriticUrl: nil
                            )
                        ),
                    ]
                ),
            ]
        },
        searchGames: { _ in
            [
                GameSearchResultItem(
                    result: SharedLogic.GameSearchResult(
                        id: "612",
                        title: "LEGO Batman",
                        cheapestPrice: 4.23,
                        cheapestDealId: "preview-deal-1",
                        steamAppId: "21000",
                        thumbnailUrl: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg",
                        internalName: "LEGOBATMAN"
                    )
                ),
                GameSearchResultItem(
                    result: SharedLogic.GameSearchResult(
                        id: "136655",
                        title: "Counter-Strike 2",
                        cheapestPrice: 0,
                        cheapestDealId: "preview-deal-2",
                        steamAppId: "730",
                        thumbnailUrl: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg",
                        internalName: "CSGO"
                    )
                ),
            ]
        },
        fetchGameDetail: { _ in
            GameDetailItem(
                detail: SharedLogic.GameDetail(
                    title: "LEGO Batman",
                    steamAppId: "21000",
                    thumbnailUrl: "https://cdn.cloudflare.steamstatic.com/steam/apps/21000/capsule_231x87.jpg",
                    cheapestPriceEverPrice: 3.99,
                    cheapestPriceEverDate: 1_543_028_665,
                    deals: [
                        SharedLogic.GameDetailDeal(
                            dealId: "preview-deal-1",
                            storeId: "23",
                            price: 4.23,
                            retailPrice: 19.99,
                            savingsPercentage: 78.84
                        ),
                        SharedLogic.GameDetailDeal(
                            dealId: "preview-deal-2",
                            storeId: "21",
                            price: 4.59,
                            retailPrice: 19.99,
                            savingsPercentage: 77.04
                        ),
                    ]
                )
            )
        }
    )
}

extension DependencyValues {
    var cheapSharkClient: CheapSharkClient {
        get { self[CheapSharkClient.self] }
        set { self[CheapSharkClient.self] = newValue }
    }
}
