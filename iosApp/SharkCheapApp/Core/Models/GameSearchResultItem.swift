//
//  GameSearchResultItem.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/08.
//

import Foundation
import SharedLogic

struct GameSearchResultItem: Equatable, Identifiable, Sendable {
    let id: String
    let title: String
    let cheapestPrice: Double
    let cheapestDealId: String
    let steamAppId: String?
    let thumbnailUrl: String
    let internalName: String

    var thumbnailURL: URL? {
        URL(string: thumbnailUrl)
    }

    var formattedCheapestPrice: String {
        String(format: "$%.2f", cheapestPrice)
    }

    init(result: SharedLogic.GameSearchResult) {
        id = result.id
        title = result.title
        cheapestPrice = result.cheapestPrice
        cheapestDealId = result.cheapestDealId
        steamAppId = result.steamAppId
        thumbnailUrl = result.thumbnailUrl
        internalName = result.internalName
    }
}
