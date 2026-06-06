package org.example.project.data.mapper

import org.example.project.data.remote.CheapSharkApiConfig
import org.example.project.data.remote.model.response.DealResponse
import org.example.project.domain.model.Deal

fun DealResponse.toDomain(): Deal {
    val metacriticBaseUrl = CheapSharkApiConfig.METACRITIC_BASE_URL
    return Deal(
        id = this.dealId,
        internalName = this.internalName,
        gameId = this.gameId,
        storeId = this.storeId,
        title = this.title,
        salePrice = this.salePrice.toDoubleOrNull() ?: 0.0,
        normalPrice = this.normalPrice.toDoubleOrNull() ?: 0.0,
        savingsPercentage = this.savings.toDoubleOrNull() ?: 0.0,
        isOnSale = this.isOnSale == "1",
        metacriticScore = this.metacriticScore.toIntOrNull() ?: 0,
        steamRatingText = this.steamRatingText,
        steamRatingPercent = this.steamRatingPercent.toIntOrNull() ?: 0,
        steamRatingCount = this.steamRatingCount.toIntOrNull() ?: 0,
        steamAppId = this.steamAppId?.takeIf { it.isNotBlank() },
        releaseDate = this.releaseDate,
        lastChange = this.lastChange,
        dealRating = this.dealRating.toDoubleOrNull() ?: 0.0,
        thumbnailUrl = this.thumb,
        metacriticUrl = if (!this.metacriticLink.isNullOrEmpty()) "$metacriticBaseUrl${this.metacriticLink}" else null
    )
}
