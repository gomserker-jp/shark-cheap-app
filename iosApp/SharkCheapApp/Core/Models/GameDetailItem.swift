//
//  GameDetailItem.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/09.
//

import Foundation
import SharedLogic

struct GameDetailItem: Equatable, Sendable {
    let title: String
    let steamAppId: String?
    let thumbnailUrl: String
    let cheapestPriceEverPrice: Double
    let cheapestPriceEverDate: Int64
    let deals: [GameDetailDealItem]

    var thumbnailURL: URL? {
        URL(string: thumbnailUrl)
    }

    var formattedCheapestPriceEver: String {
        String(format: "$%.2f", cheapestPriceEverPrice)
    }

    init(detail: SharedLogic.GameDetail) {
        title = detail.title
        steamAppId = detail.steamAppId
        thumbnailUrl = detail.thumbnailUrl
        cheapestPriceEverPrice = detail.cheapestPriceEverPrice
        cheapestPriceEverDate = detail.cheapestPriceEverDate
        deals = detail.deals.map(GameDetailDealItem.init(deal:))
    }
}

struct GameDetailDealItem: Equatable, Identifiable, Sendable {
    let id: String
    let storeId: String
    let price: Double
    let retailPrice: Double
    let savingsPercentage: Double

    var discountRate: Int {
        Int(savingsPercentage.rounded())
    }

    var formattedPrice: String {
        String(format: "$%.2f", price)
    }

    var formattedRetailPrice: String {
        String(format: "$%.2f", retailPrice)
    }

    var safariDestination: SafariDestination? {
        guard let url = CheapSharkRedirectURL.deal(id: id) else { return nil }
        return SafariDestination(url: url)
    }

    init(deal: SharedLogic.GameDetailDeal) {
        id = deal.dealId
        storeId = deal.storeId
        price = deal.price
        retailPrice = deal.retailPrice
        savingsPercentage = deal.savingsPercentage
    }
}
