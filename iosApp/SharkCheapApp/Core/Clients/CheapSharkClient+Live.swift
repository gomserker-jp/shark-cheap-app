//
//  CheapSharkClient+Live.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import Foundation
import RealmSwift
import SharedLogic

extension CheapSharkClient {
    static let liveValue = CheapSharkClient(
        fetchStores: {
            try await CheapSharkBridge().fetchStores().map(StoreItem.init(store:))
        },
        saveStores: { stores in
            try await MainActor.run {
                let realm = try Realm()
                try realm.write {
                    for store in stores {
                        realm.add(StoreMaster(storeItem: store), update: .modified)
                    }
                }
            }
        },
        fetchDeals: { query in
            let page = try await CheapSharkBridge().fetchDeals(query: query)
            return (
                page.deals.map(DealItem.init(deal:)),
                totalPageCount: page.totalPageCount.map { Int(truncating: $0) }
            )
        },
        fetchTodaysSpecialDeals: {
            let page = try await CheapSharkBridge().fetchTodaysSpecialDeals()
            return page.deals.map(DealItem.init(deal:))
        },
        fetchStoreDealsSections: {
            let sections = try await CheapSharkBridge().fetchStoreDealsSections()
            return sections.map(StoreDealsSectionItem.init(section:))
        }
    )
}
