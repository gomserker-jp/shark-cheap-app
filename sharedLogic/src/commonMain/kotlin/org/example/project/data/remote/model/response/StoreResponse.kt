package org.example.project.data.remote.model.response

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class StoreResponse(
    @SerialName("storeID")
    val storeId: String,
    @SerialName("storeName")
    val storeName: String,
    @SerialName("isActive")
    val isActive: Int,
    @SerialName("images")
    val images: StoreImageResponse
)

@Serializable
data class StoreImageResponse(
    @SerialName("banner")
    val banner: String,
    @SerialName("logo")
    val logo: String,
    @SerialName("icon")
    val icon: String
)
