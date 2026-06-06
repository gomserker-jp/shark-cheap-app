package org.example.project.data.remote.model.response

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class DealResponse(
    @SerialName("internalName") val internalName: String,
    @SerialName("title") val title: String,
    @SerialName("metacriticLink") val metacriticLink: String?,
    @SerialName("dealID") val dealId: String,
    @SerialName("storeID") val storeId: String,
    @SerialName("gameID") val gameId: String,
    @SerialName("salePrice") val salePrice: String,
    @SerialName("normalPrice") val normalPrice: String,
    @SerialName("isOnSale") val isOnSale: String,
    @SerialName("savings") val savings: String,
    @SerialName("metacriticScore") val metacriticScore: String,
    @SerialName("steamRatingText") val steamRatingText: String? = null,
    @SerialName("steamRatingPercent") val steamRatingPercent: String,
    @SerialName("steamRatingCount") val steamRatingCount: String,
    @SerialName("steamAppID") val steamAppId: String,
    @SerialName("releaseDate") val releaseDate: Long,
    @SerialName("lastChange") val lastChange: Long,
    @SerialName("dealRating") val dealRating: String,
    @SerialName("thumb") val thumb: String
)
