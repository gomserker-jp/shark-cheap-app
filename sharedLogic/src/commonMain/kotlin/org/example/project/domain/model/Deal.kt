package org.example.project.domain.model

data class Deal(
    val id: String,
    val internalName: String,
    val gameId: String,
    val storeId: String,
    val title: String,
    val salePrice: Double,
    val normalPrice: Double,
    val savingsPercentage: Double,
    val isOnSale: Boolean,
    val metacriticScore: Int,
    val steamRatingText: String?,
    val steamRatingPercent: Int,
    val steamRatingCount: Int,
    val steamAppId: String?,
    val releaseDate: Long,
    val lastChange: Long,
    val dealRating: Double,
    val thumbnailUrl: String,
    val metacriticUrl: String?
)
