package org.example.project.data.mapper

import org.example.project.data.remote.model.response.GameSearchResponse
import org.example.project.domain.model.GameSearchResult

fun GameSearchResponse.toDomain(): GameSearchResult {
    return GameSearchResult(
        id = this.gameId,
        title = this.external,
        cheapestPrice = this.cheapest.toDoubleOrNull() ?: 0.0,
        cheapestDealId = this.cheapestDealId,
        steamAppId = this.steamAppId,
        thumbnailUrl = this.thumb,
        internalName = this.internalName
    )
}
