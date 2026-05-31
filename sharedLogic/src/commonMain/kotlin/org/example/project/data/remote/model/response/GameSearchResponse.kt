package org.example.project.data.remote.model.response

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class GameSearchResponse(
    @SerialName("gameID")
    val gameId: String,
    @SerialName("steamAppID")
    val steamAppId: String?,
    @SerialName("cheapest")
    val cheapest: String,
    @SerialName("cheapestDealID")
    val cheapestDealId: String,
    @SerialName("external")
    val external: String,
    @SerialName("internalName")
    val internalName: String,
    @SerialName("thumb")
    val thumb: String
)
