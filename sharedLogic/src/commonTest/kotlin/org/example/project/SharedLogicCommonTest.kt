package org.example.project

import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith
import kotlin.test.assertFalse
import org.example.project.domain.model.Deal
import org.example.project.domain.model.DealsQuery
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

    private fun sampleDeal(savingsPercentage: Double): Deal {
        return Deal(
            id = "deal-1",
            internalName = "SAMPLEGAME",
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
