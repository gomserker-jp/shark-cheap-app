package org.example.project.data.remote.model.response

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class GameLookupResponse(
    @SerialName("info") val info: GameLookupInfoResponse,
    @SerialName("cheapestPriceEver") val cheapestPriceEver: CheapestPriceResponse,
    @SerialName("deals") val deals: List<GameLookupDealResponse>
)

@Serializable
data class GameLookupInfoResponse(
    @SerialName("title") val title: String,
    @SerialName("steamAppID") val steamAppId: String?,
    @SerialName("thumb") val thumb: String
)

@Serializable
data class GameLookupDealResponse(
    @SerialName("storeID") val storeId: String,
    @SerialName("dealID") val dealId: String,
    @SerialName("price") val price: String,
    @SerialName("retailPrice") val retailPrice: String,
    @SerialName("savings") val savings: String
)
