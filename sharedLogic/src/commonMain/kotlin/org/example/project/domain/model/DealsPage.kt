package org.example.project.domain.model

data class DealsPage(
    val deals: List<Deal>,
    val totalPageCount: Int?
)
