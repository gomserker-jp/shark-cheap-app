package org.example.project.domain.model

data class DealDetails(
    val gameId: String,
    val storeId: String,
    val title: String,
    val steamAppId: String?,
    val salePrice: Double,
    val retailPrice: Double,
    val steamRatingText: String?,
    val steamRatingPercent: Int?,
    val steamRatingCount: Int?,
    val metacriticScore: Int?,
    val metacriticUrl: String?,
    val releaseDate: Long, // Unix timestamp in seconds
    val publisher: String?,
    val usesSteamworks: Boolean,
    val thumbnailUrl: String,
    val cheapestPriceEverPrice: Double,
    val cheapestPriceEverDate: Long, // Unix timestamp in seconds
    val cheaperStoreDeals: List<CheaperStoreDeal>
)

data class CheaperStoreDeal(
    val dealId: String,
    val storeId: String,
    val salePrice: Double,
    val retailPrice: Double
)
