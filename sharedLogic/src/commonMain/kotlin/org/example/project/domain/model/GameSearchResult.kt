package org.example.project.domain.model

data class GameSearchResult(
    val id: String,
    val title: String,
    val cheapestPrice: Double,
    val cheapestDealId: String,
    val steamAppId: String?,
    val thumbnailUrl: String,
    val internalName: String
)
