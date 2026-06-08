package org.example.project.domain.model

data class GameSearchQuery(
    val title: String? = null,
    val steamAppId: Int? = null,
    val limit: Int = 60,
    val exact: Boolean = false
) {
    init {
        require(title != null || steamAppId != null) {
            "title or steamAppId is required"
        }
        
        require(limit in 1..60) {
            "limit error"
        }
    }

    fun toQueryParameters(): Map<String, String> = buildMap {
        title?.takeIf { it.isNotBlank() }?.let { put("title", it) }
        steamAppId?.let { put("steamAppID", it.toString()) }
        if (limit != 60) put("limit", limit.toString())
        if (exact) put("exact", "1")
    }
}
