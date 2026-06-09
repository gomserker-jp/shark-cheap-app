package org.example.project.data.mapper

import org.example.project.data.remote.model.response.GameLookupResponse
import org.example.project.domain.model.GameDetail
import org.example.project.domain.model.GameDetailDeal

fun GameLookupResponse.toDomain(): GameDetail {
    return GameDetail(
        title = info.title,
        steamAppId = info.steamAppId,
        thumbnailUrl = info.thumb,
        cheapestPriceEverPrice = cheapestPriceEver.price.toDoubleOrNull() ?: 0.0,
        cheapestPriceEverDate = cheapestPriceEver.date,
        deals = deals.map {
            GameDetailDeal(
                dealId = it.dealId,
                storeId = it.storeId,
                price = it.price.toDoubleOrNull() ?: 0.0,
                retailPrice = it.retailPrice.toDoubleOrNull() ?: 0.0,
                savingsPercentage = it.savings.toDoubleOrNull() ?: 0.0
            )
        }
    )
}
