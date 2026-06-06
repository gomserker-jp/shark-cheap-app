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

    init(
        fetchStores: @escaping @Sendable () async throws -> [StoreItem] = { [] },
        saveStores: @escaping @Sendable ([StoreItem]) async throws -> Void = { _ in },
        fetchDeals: @escaping @Sendable (DealsQuery) async throws -> ([DealItem], totalPageCount: Int?) = { _ in
            ([], totalPageCount: nil)
        },
        fetchTodaysSpecialDeals: @escaping @Sendable () async throws -> [DealItem] = {
            []
        }
    ) {
        self.fetchStores = fetchStores
        self.saveStores = saveStores
        self.fetchDeals = fetchDeals
        self.fetchTodaysSpecialDeals = fetchTodaysSpecialDeals
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
        }
    )
}

extension DependencyValues {
    var cheapSharkClient: CheapSharkClient {
        get { self[CheapSharkClient.self] }
        set { self[CheapSharkClient.self] = newValue }
    }
}
