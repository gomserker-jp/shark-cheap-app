package org.example.project.domain.model

data class DealsQuery(
    val storeIds: List<String>? = null,
    val pageNumber: Int = 0,
    val pageSize: Int = 60,
    val sortBy: DealSortBy = DealSortBy.DealRating,
    val desc: Boolean = false,
    val lowerPrice: Int? = null,
    val upperPrice: Int? = null,
    val metacritic: Int? = null,
    val steamRating: Int? = null,
    val minimumReviewCount: Int? = null,
    val maxAge: Int? = null,
    val steamAppIds: List<String>? = null,
    val title: String? = null,
    val exact: Boolean = false,
    val aaa: Boolean = false,
    val steamworks: Boolean = false,
    val onSale: Boolean = false,
    val output: String? = null
) {
    init {
        require(pageNumber >= 0) { "pageNumber must be >= 0" }
        require(pageSize in 1..60) { "pageSize must be between 1 and 60" }
        maxAge?.let {
            require(it in 1..2500) { "maxAge must be between 1 and 2500" }
        }
        lowerPrice?.let { require(it >= 0) { "lowerPrice must be >= 0" } }
        if (lowerPrice != null && upperPrice != null) {
            require(upperPrice >= lowerPrice) { "upperPrice must be >= lowerPrice" }
        }
    }

    fun toQueryParameters(): Map<String, String> = buildMap {
        storeIds?.takeIf { it.isNotEmpty() }?.let { put("storeID", it.joinToString(",")) }
        if (pageNumber != 0) put("pageNumber", pageNumber.toString())
        if (pageSize != 60) put("pageSize", pageSize.toString())
        if (sortBy != DealSortBy.DealRating) put("sortBy", sortBy.apiValue)
        if (desc) put("desc", "1")
        lowerPrice?.takeIf { it > 0 }?.let { put("lowerPrice", it.toString()) }
        upperPrice?.takeIf { it < 50 }?.let { put("upperPrice", it.toString()) }
        metacritic?.let { put("metacritic", it.toString()) }
        steamRating?.let { put("steamRating", it.toString()) }
        minimumReviewCount?.let { put("minimumReviewCount", it.toString()) }
        maxAge?.let { put("maxAge", it.toString()) }
        steamAppIds?.takeIf { it.isNotEmpty() }?.let { put("steamAppID", it.joinToString(",")) }
        title?.takeIf { it.isNotBlank() }?.let { put("title", it) }
        if (exact) put("exact", "1")
        if (aaa) put("AAA", "1")
        if (steamworks) put("steamworks", "1")
        if (onSale) put("onSale", "1")
        output?.takeIf { it.isNotBlank() }?.let { put("output", it) }
    }
}
