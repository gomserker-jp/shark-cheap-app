package org.example.project

import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith
import kotlin.test.assertFalse
import org.example.project.data.mapper.toDomain
import org.example.project.data.remote.CheapSharkJson
import org.example.project.data.remote.model.response.GameLookupResponse
import org.example.project.domain.model.Deal
import org.example.project.domain.model.DealsQuery
import org.example.project.domain.model.Store
import org.example.project.domain.model.StoreDealsCriteria
import org.example.project.domain.model.StoreDisplayOrder
import org.example.project.domain.model.TodaysSpecialDealsCriteria
import kotlin.test.assertTrue

class SharedLogicCommonTest {

    @Test
    fun dealsQuery_rejectsPageSizeAbove60() {
        assertFailsWith<IllegalArgumentException> {
            DealsQuery(pageSize = 61)
        }
    }

    @Test
    fun dealsQuery_rejectsInvalidMaxAge() {
        assertFailsWith<IllegalArgumentException> {
            DealsQuery(maxAge = 0)
        }
        assertFailsWith<IllegalArgumentException> {
            DealsQuery(maxAge = 2501)
        }
    }

    @Test
    fun dealsQuery_acceptsValidMaxAge() {
        val query = DealsQuery(maxAge = 100)
        assertEquals("100", query.toQueryParameters()["maxAge"])
    }

    @Test
    fun dealsQuery_toQueryParameters_includesNonDefaultValues() {
        val params = DealsQuery(
            storeIds = listOf("1"),
            upperPrice = 15,
            onSale = true,
            metacritic = TodaysSpecialDealsCriteria.MIN_METACRITIC
        ).toQueryParameters()

        assertEquals("1", params["storeID"])
        assertEquals("15", params["upperPrice"])
        assertEquals("1", params["onSale"])
        assertEquals("80", params["metacritic"])
        assertFalse(params.containsKey("pageNumber"))
        assertFalse(params.containsKey("pageSize"))
        assertFalse(params.containsKey("sortBy"))
    }

    @Test
    fun dealsQuery_onSaleTrue_mapsToApiFlag() {
        val params = DealsQuery(onSale = true).toQueryParameters()
        assertEquals("1", params["onSale"])
    }

    @Test
    fun todaysSpecialDealsCriteria_queryIncludesMetacritic() {
        val params = DealsQuery(
            metacritic = TodaysSpecialDealsCriteria.MIN_METACRITIC
        ).toQueryParameters()

        assertEquals("80", params["metacritic"])
        assertFalse(params.containsKey("onSale"))
    }

    @Test
    fun todaysSpecialDeals_savingsFilter_passesAboveThreshold() {
        val deal = sampleDeal(savingsPercentage = 60.0)
        assertTrue(deal.savingsPercentage >= TodaysSpecialDealsCriteria.MIN_SAVINGS_PERCENT)
    }

    @Test
    fun todaysSpecialDeals_savingsFilter_rejectsBelowThreshold() {
        val deal = sampleDeal(savingsPercentage = 40.0)
        assertFalse(deal.savingsPercentage >= TodaysSpecialDealsCriteria.MIN_SAVINGS_PERCENT)
    }

    @Test
    fun storeDealsCriteria_savingsFilter_passesAboveThreshold() {
        val deal = sampleDeal(savingsPercentage = 35.0)
        val filtered = StoreDealsCriteria.filterDeals(listOf(deal))

        assertEquals(1, filtered.size)
    }

    @Test
    fun storeDealsCriteria_savingsFilter_rejectsBelowThreshold() {
        val deal = sampleDeal(savingsPercentage = 25.0)
        val filtered = StoreDealsCriteria.filterDeals(listOf(deal))

        assertTrue(filtered.isEmpty())
    }

    @Test
    fun storeDisplayOrder_sortsPriorityStoresFirstThenAlphabetically() {
        val stores = listOf(
            sampleStore(id = "31", name = "Fanatical"),
            sampleStore(id = "7", name = "GOG"),
            sampleStore(id = "13", name = "Uplay"),
            sampleStore(id = "25", name = "Epic Games Store"),
            sampleStore(id = "1", name = "Steam"),
            sampleStore(id = "11", name = "Humble Store"),
        )

        val sorted = StoreDisplayOrder.sort(stores)

        assertEquals(listOf("1", "25", "11", "13", "31", "7"), sorted.map { it.id })
    }

    @Test
    fun gameLookupResponse_decodesAndMapsToDomain() {
        val json = """
            {
              "info": {
                "title": "LEGO Batman",
                "steamAppID": "21000",
                "thumb": "https://example.com/thumb.jpg"
              },
              "cheapestPriceEver": {
                "price": "3.99",
                "date": 1543028665
              },
              "deals": [
                {
                  "storeID": "23",
                  "dealID": "deal-1",
                  "price": "4.23",
                  "retailPrice": "19.99",
                  "savings": "78.839420"
                }
              ]
            }
        """.trimIndent()

        val response = CheapSharkJson.instance.decodeFromString<GameLookupResponse>(json)
        val detail = response.toDomain()

        assertEquals("LEGO Batman", detail.title)
        assertEquals("21000", detail.steamAppId)
        assertEquals(3.99, detail.cheapestPriceEverPrice)
        assertEquals(1_543_028_665L, detail.cheapestPriceEverDate)
        assertEquals(1, detail.deals.size)
        assertEquals("deal-1", detail.deals[0].dealId)
        assertEquals("23", detail.deals[0].storeId)
        assertEquals(4.23, detail.deals[0].price)
        assertEquals(78.839420, detail.deals[0].savingsPercentage)
    }

    @Test
    fun todaysSpecialDeals_distinctByInternalName_keepsFirstDealOnly() {
        val deals = listOf(
            sampleDeal(internalName = "SAMEGAME", savingsPercentage = 60.0, dealId = "deal-1"),
            sampleDeal(internalName = "SAMEGAME", savingsPercentage = 70.0, dealId = "deal-2"),
            sampleDeal(internalName = "OTHERGAME", savingsPercentage = 55.0, dealId = "deal-3"),
        )

        val filtered = TodaysSpecialDealsCriteria.filterDeals(deals)

        assertEquals(2, filtered.size)
        assertEquals("deal-1", filtered[0].id)
        assertEquals("deal-3", filtered[1].id)
    }

    private fun sampleStore(
        id: String,
        name: String,
    ): Store {
        return Store(
            id = id,
            name = name,
            isActive = true,
            bannerUrl = "",
            logoUrl = "",
            iconUrl = "",
        )
    }

    private fun sampleDeal(
        savingsPercentage: Double,
        internalName: String = "SAMPLEGAME",
        dealId: String = "deal-1",
    ): Deal {
        return Deal(
            id = dealId,
            internalName = internalName,
            gameId = "1",
            storeId = "1",
            title = "Sample Game",
            salePrice = 9.99,
            normalPrice = 19.99,
            savingsPercentage = savingsPercentage,
            isOnSale = true,
            metacriticScore = 85,
            steamRatingText = "Very Positive",
            steamRatingPercent = 90,
            steamRatingCount = 1000,
            steamAppId = "123",
            releaseDate = 1_000_000_000L,
            lastChange = 1_000_000_100L,
            dealRating = 9.0,
            thumbnailUrl = "https://example.com/thumb.jpg",
            metacriticUrl = null
        )
    }
}
