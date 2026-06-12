package org.example.project.domain.model

data class GameDetail(
    val title: String,
    val steamAppId: String?,
    val thumbnailUrl: String,
    val cheapestPriceEverPrice: Double,
    val cheapestPriceEverDate: Long,
    val deals: List<GameDetailDeal>
)

data class GameDetailDeal(
    val dealId: String,
    val storeId: String,
    val price: Double,
    val retailPrice: Double,
    val savingsPercentage: Double
)
