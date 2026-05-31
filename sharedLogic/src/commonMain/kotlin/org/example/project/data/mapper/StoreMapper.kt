package org.example.project.data.mapper

import org.example.project.data.remote.CheapSharkApiConfig
import org.example.project.data.remote.model.response.StoreResponse
import org.example.project.domain.model.Store

fun StoreResponse.toDomain(): Store {
    val baseUrl = CheapSharkApiConfig.IMAGE_BASE_URL
    return Store(
        id = this.storeId,
        name = this.storeName,
        isActive = this.isActive == 1,
        bannerUrl = "$baseUrl${this.images.banner}",
        logoUrl = "$baseUrl${this.images.logo}",
        iconUrl = "$baseUrl${this.images.icon}"
    )
}
