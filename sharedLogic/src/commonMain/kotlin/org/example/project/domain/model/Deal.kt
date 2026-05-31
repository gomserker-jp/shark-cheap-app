package org.example.project.domain.model

data class Deal(
    val id: String,
    val gameId: String,
    val storeId: String,
    val title: String,
    val salePrice: Double,
    val normalPrice: Double,
    val savingsPercentage: Double,
    val isOnSale: Boolean,
    val dealRating: Double,
    val thumbnailUrl: String,
    val metacriticUrl: String?
)
