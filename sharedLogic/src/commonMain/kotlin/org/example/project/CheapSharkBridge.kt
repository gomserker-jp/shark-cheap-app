package org.example.project

import io.ktor.client.request.get
import io.ktor.client.statement.bodyAsText
import kotlinx.serialization.json.Json
import org.example.project.data.mapper.toDomain
import org.example.project.data.remote.CheapSharkApiConfig
import org.example.project.data.remote.CheapSharkHttpClient
import org.example.project.data.remote.model.response.StoreResponse
import org.example.project.domain.model.Store

class CheapSharkBridge {
    suspend fun fetchStores(): List<Store> {
        val body = CheapSharkHttpClient.client
            .get("${CheapSharkApiConfig.BASE_URL}/stores")
            .bodyAsText()
        return Json.decodeFromString<List<StoreResponse>>(body)
            .map { it.toDomain() }
            .filter { it.isActive }
    }
}
