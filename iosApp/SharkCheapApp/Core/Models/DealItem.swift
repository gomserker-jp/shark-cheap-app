//
//  DealItem.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import Foundation
import SharedLogic

struct DealItem: Equatable, Identifiable, Sendable {
    let id: String
    let internalName: String
    let gameId: String
    let storeId: String
    let title: String
    let salePrice: Double
    let normalPrice: Double
    let savingsPercentage: Double
    let isOnSale: Bool
    let metacriticScore: Int
    let steamRatingText: String?
    let steamRatingPercent: Int
    let steamRatingCount: Int
    let steamAppId: String?
    let releaseDate: Int64
    let lastChange: Int64
    let dealRating: Double
    let thumbnailUrl: String
    let metacriticUrl: String?

    var discountRate: Int {
        Int(savingsPercentage.rounded())
    }

    var safariDestination: SafariDestination? {
        guard let url = CheapSharkRedirectURL.deal(id: id) else { return nil }
        return SafariDestination(url: url)
    }

    init(deal: SharedLogic.Deal) {
        id = deal.id
        internalName = deal.internalName
        gameId = deal.gameId
        storeId = deal.storeId
        title = deal.title
        salePrice = deal.salePrice
        normalPrice = deal.normalPrice
        savingsPercentage = deal.savingsPercentage
        isOnSale = deal.isOnSale
        metacriticScore = Int(deal.metacriticScore)
        steamRatingText = deal.steamRatingText
        steamRatingPercent = Int(deal.steamRatingPercent)
        steamRatingCount = Int(deal.steamRatingCount)
        steamAppId = deal.steamAppId
        releaseDate = deal.releaseDate
        lastChange = deal.lastChange
        dealRating = deal.dealRating
        thumbnailUrl = deal.thumbnailUrl
        metacriticUrl = deal.metacriticUrl
    }
}
