package org.example.project.domain.model

object StoreDisplayOrder {
    val PRIORITY_STORE_IDS = listOf("1", "25", "11", "13")

    private val PRIORITY_STORE_NAMES = listOf(
        "Steam",
        "Epic Games Store",
        "Humble Store",
        "Uplay",
    )

    fun sort(stores: List<Store>): List<Store> {
        val remaining = stores.toMutableList()
        val priorityStores = mutableListOf<Store>()

        for (priorityId in PRIORITY_STORE_IDS) {
            val index = remaining.indexOfFirst { it.id == priorityId }
            if (index >= 0) {
                priorityStores.add(remaining.removeAt(index))
            }
        }

        for (priorityName in PRIORITY_STORE_NAMES) {
            val index = remaining.indexOfFirst { it.name == priorityName }
            if (index >= 0) {
                priorityStores.add(remaining.removeAt(index))
            }
        }

        return priorityStores + remaining.sortedBy { it.name }
    }
}
