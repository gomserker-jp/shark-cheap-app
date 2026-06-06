package org.example.project.domain.model

object TodaysSpecialDealsCriteria {
    const val MIN_METACRITIC = 80
    const val MIN_SAVINGS_PERCENT = 50.0

    fun filterDeals(deals: List<Deal>): List<Deal> {
        return deals
            .filter { it.savingsPercentage >= MIN_SAVINGS_PERCENT }
            .distinctBy { it.internalName }
    }
}
