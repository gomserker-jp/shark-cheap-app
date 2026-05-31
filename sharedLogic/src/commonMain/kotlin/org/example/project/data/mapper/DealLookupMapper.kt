package org.example.project.data.mapper

import org.example.project.data.remote.CheapSharkApiConfig
import org.example.project.data.remote.model.response.DealLookupResponse
import org.example.project.domain.model.CheaperStoreDeal
import org.example.project.domain.model.DealDetails

fun DealLookupResponse.toDomain(): DealDetails {
    val metacriticBaseUrl = CheapSharkApiConfig.METACRITIC_BASE_URL
    val info = this.gameInfo
    
    return DealDetails(
        gameId = info.gameId,
        storeId = info.storeId,
        title = info.name,
        steamAppId = info.steamAppId,
        salePrice = info.salePrice.toDoubleOrNull() ?: 0.0,
        retailPrice = info.retailPrice.toDoubleOrNull() ?: 0.0,
        steamRatingText = info.steamRatingText,
        steamRatingPercent = info.steamRatingPercent?.toIntOrNull(),
        steamRatingCount = info.steamRatingCount?.toIntOrNull(),
        metacriticScore = info.metacriticScore?.toIntOrNull(),
        metacriticUrl = if (!info.metacriticLink.isNullOrEmpty()) "$metacriticBaseUrl${info.metacriticLink}" else null,
        releaseDate = info.releaseDate,
        publisher = info.publisher,
        usesSteamworks = info.steamworks == "1",
        thumbnailUrl = info.thumb,
        cheapestPriceEverPrice = this.cheapestPrice.price.toDoubleOrNull() ?: 0.0,
        cheapestPriceEverDate = this.cheapestPrice.date,
        cheaperStoreDeals = this.cheaperStores.map {
            CheaperStoreDeal(
                dealId = it.dealId,
                storeId = it.storeId,
                salePrice = it.salePrice.toDoubleOrNull() ?: 0.0,
                retailPrice = it.retailPrice.toDoubleOrNull() ?: 0.0
            )
        }
    )
}
