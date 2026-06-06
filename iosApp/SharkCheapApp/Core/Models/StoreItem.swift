//
//  StoreItem.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import Foundation
import SharedLogic

struct StoreItem: Equatable, Identifiable, Sendable {
    let id: String
    let name: String
    let isActive: Bool
    let bannerUrl: String
    let logoUrl: String
    let iconUrl: String

    init(
        id: String,
        name: String,
        isActive: Bool = true,
        bannerUrl: String = "",
        logoUrl: String,
        iconUrl: String = ""
    ) {
        self.id = id
        self.name = name
        self.isActive = isActive
        self.bannerUrl = bannerUrl
        self.logoUrl = logoUrl
        self.iconUrl = iconUrl
    }

    init(store: SharedLogic.Store) {
        id = store.id
        name = store.name
        isActive = store.isActive
        bannerUrl = store.bannerUrl
        logoUrl = store.logoUrl
        iconUrl = store.iconUrl
    }
}
