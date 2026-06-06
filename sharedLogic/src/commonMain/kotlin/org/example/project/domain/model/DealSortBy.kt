package org.example.project.domain.model

enum class DealSortBy(val apiValue: String) {
    DealRating("DealRating"),
    Title("Title"),
    Savings("Savings"),
    Price("Price"),
    Metacritic("Metacritic"),
    Reviews("Reviews"),
    ReviewCount("ReviewCount"),
    Release("Release"),
    Store("Store"),
    Recent("Recent")
}
