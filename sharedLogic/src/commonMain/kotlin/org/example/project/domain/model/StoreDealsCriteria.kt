package org.example.project.domain.model

object StoreDealsCriteria {
    const val MIN_METACRITIC = 80
    const val MIN_SAVINGS_PERCENT = 30.0

    fun filterDeals(deals: List<Deal>): List<Deal> {
        return deals.filter { it.savingsPercentage >= MIN_SAVINGS_PERCENT }
    }
}
