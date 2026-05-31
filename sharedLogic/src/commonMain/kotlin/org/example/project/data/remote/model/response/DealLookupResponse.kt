package org.example.project.data.remote.model.response

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class DealLookupResponse(
    @SerialName("gameInfo") val gameInfo: DealLookupGameInfoResponse,
    @SerialName("cheaperStores") val cheaperStores: List<CheaperStoreResponse>,
    @SerialName("cheapestPrice") val cheapestPrice: CheapestPriceResponse
)

@Serializable
data class DealLookupGameInfoResponse(
    @SerialName("storeID") val storeId: String,
    @SerialName("gameID") val gameId: String,
    @SerialName("name") val name: String,
    @SerialName("steamAppID") val steamAppId: String?,
    @SerialName("salePrice") val salePrice: String,
    @SerialName("retailPrice") val retailPrice: String,
    @SerialName("steamRatingText") val steamRatingText: String?,
    @SerialName("steamRatingPercent") val steamRatingPercent: String?,
    @SerialName("steamRatingCount") val steamRatingCount: String?,
    @SerialName("metacriticScore") val metacriticScore: String?,
    @SerialName("metacriticLink") val metacriticLink: String?,
    @SerialName("releaseDate") val releaseDate: Long, // Unix timestamp in seconds
    @SerialName("publisher") val publisher: String?,
    @SerialName("steamworks") val steamworks: String?,
    @SerialName("thumb") val thumb: String
)

@Serializable
data class CheaperStoreResponse(
    @SerialName("dealID") val dealId: String,
    @SerialName("storeID") val storeId: String,
    @SerialName("salePrice") val salePrice: String,
    @SerialName("retailPrice") val retailPrice: String
)

@Serializable
data class CheapestPriceResponse(
    @SerialName("price") val price: String,
    @SerialName("date") val date: Long // Unix timestamp in seconds
)
