package org.example.project

import io.ktor.client.request.get
import io.ktor.client.request.parameter
import io.ktor.client.statement.bodyAsText
import kotlinx.serialization.json.Json
import org.example.project.data.mapper.toDomain
import org.example.project.data.remote.CheapSharkApiConfig
import org.example.project.data.remote.CheapSharkHttpClient
import org.example.project.data.remote.model.response.DealResponse
import org.example.project.data.remote.model.response.StoreResponse
import org.example.project.domain.model.DealsPage
import org.example.project.domain.model.DealsQuery
import org.example.project.domain.model.Store
import org.example.project.domain.model.TodaysSpecialDealsCriteria

class CheapSharkBridge {
    suspend fun fetchStores(): List<Store> {
        val body = CheapSharkHttpClient.client
            .get("${CheapSharkApiConfig.BASE_URL}/stores")
            .bodyAsText()
        return Json.decodeFromString<List<StoreResponse>>(body)
            .map { it.toDomain() }
            .filter { it.isActive }
    }

    suspend fun fetchDeals(query: DealsQuery = DealsQuery()): DealsPage {
        val response = CheapSharkHttpClient.client.get("${CheapSharkApiConfig.BASE_URL}/deals") {
            query.toQueryParameters().forEach { (key, value) ->
                parameter(key, value)
            }
        }
        val body = response.bodyAsText()
        val deals = Json.decodeFromString<List<DealResponse>>(body)
            .map { it.toDomain() }
        val totalPageCount = response.headers["X-Total-Page-Count"]?.toIntOrNull()
        return DealsPage(deals = deals, totalPageCount = totalPageCount)
    }

    suspend fun fetchTodaysSpecialDeals(): DealsPage {
        val page = fetchDeals(
            DealsQuery(
                metacritic = TodaysSpecialDealsCriteria.MIN_METACRITIC
            )
        )
        return page.copy(
            deals = page.deals.filter {
                it.savingsPercentage >= TodaysSpecialDealsCriteria.MIN_SAVINGS_PERCENT
            }
        )
    }
}
