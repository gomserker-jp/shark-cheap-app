package org.example.project

import io.ktor.client.request.get
import io.ktor.client.request.parameter
import io.ktor.client.statement.bodyAsText
import org.example.project.data.mapper.toDomain
import org.example.project.data.remote.CheapSharkApiConfig
import org.example.project.data.remote.CheapSharkHttpClient
import org.example.project.data.remote.CheapSharkJson
import org.example.project.data.remote.model.response.DealResponse
import org.example.project.data.remote.model.response.GameSearchResponse
import org.example.project.data.remote.model.response.StoreResponse
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.coroutineScope
import org.example.project.domain.model.DealsPage
import org.example.project.domain.model.DealsQuery
import org.example.project.domain.model.GameSearchQuery
import org.example.project.domain.model.GameSearchResult
import org.example.project.domain.model.Store
import org.example.project.domain.model.StoreDealsCriteria
import org.example.project.domain.model.StoreDealsSection
import org.example.project.domain.model.StoreDisplayOrder
import org.example.project.domain.model.TodaysSpecialDealsCriteria

class CheapSharkBridge {
    suspend fun fetchStores(): List<Store> {
        val body = CheapSharkHttpClient.client
            .get("${CheapSharkApiConfig.BASE_URL}/stores")
            .bodyAsText()
        return CheapSharkJson.instance.decodeFromString<List<StoreResponse>>(body)
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
        val deals = CheapSharkJson.instance.decodeFromString<List<DealResponse>>(body)
            .map { it.toDomain() }
        val totalPageCount = response.headers["X-Total-Page-Count"]?.toIntOrNull()
        return DealsPage(deals = deals, totalPageCount = totalPageCount)
    }

    suspend fun fetchGames(query: GameSearchQuery): List<GameSearchResult> {
        val body = CheapSharkHttpClient.client.get("${CheapSharkApiConfig.BASE_URL}/games") {
            query.toQueryParameters().forEach { (key, value) ->
                parameter(key, value)
            }
        }.bodyAsText()
        return CheapSharkJson.instance.decodeFromString<List<GameSearchResponse>>(body)
            .map { it.toDomain() }
    }

    suspend fun fetchGames(title: String): List<GameSearchResult> =
        fetchGames(GameSearchQuery(title = title))

    suspend fun fetchTodaysSpecialDeals(): DealsPage {
        val page = fetchDeals(
            DealsQuery(
                metacritic = TodaysSpecialDealsCriteria.MIN_METACRITIC
            )
        )
        return page.copy(
            deals = TodaysSpecialDealsCriteria.filterDeals(page.deals)
        )
    }

    suspend fun fetchStoreDealsSections(): List<StoreDealsSection> = coroutineScope {
        val stores = StoreDisplayOrder.sort(fetchStores())
        stores.map { store ->
            async {
                val page = fetchDeals(
                    DealsQuery(
                        storeIds = listOf(store.id),
                        metacritic = StoreDealsCriteria.MIN_METACRITIC,
                        pageNumber = 0,
                    )
                )
                StoreDealsSection(
                    store = store,
                    deals = StoreDealsCriteria.filterDeals(page.deals),
                )
            }
        }.awaitAll()
            .filter { it.deals.isNotEmpty() }
    }
}
