//
//  StoreDealsSectionItem.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import Foundation
import SharedLogic

struct StoreDealsSectionItem: Equatable, Identifiable, Sendable {
    let id: String
    let storeName: String
    let logoUrl: String
    let deals: [DealItem]

    init(id: String, storeName: String, logoUrl: String = "", deals: [DealItem]) {
        self.id = id
        self.storeName = storeName
        self.logoUrl = logoUrl
        self.deals = deals
    }

    init(section: SharedLogic.StoreDealsSection) {
        id = section.store.id
        storeName = section.store.name
        logoUrl = section.store.logoUrl
        deals = section.deals.map(DealItem.init(deal:))
    }
}
