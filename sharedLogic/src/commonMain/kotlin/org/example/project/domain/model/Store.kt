package org.example.project.domain.model

data class Store(
    val id: String,
    val name: String,
    val isActive: Boolean,
    val bannerUrl: String,
    val logoUrl: String,
    val iconUrl: String
)
