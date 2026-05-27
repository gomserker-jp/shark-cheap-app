package org.example.project

import io.ktor.client.request.get
import io.ktor.client.statement.bodyAsText
import org.example.project.data.remote.CheapSharkApiConfig
import org.example.project.data.remote.CheapSharkHttpClient

class CheapSharkBridge {
    suspend fun fetchStoresRaw(): String {
        return CheapSharkHttpClient.client
            .get("${CheapSharkApiConfig.BASE_URL}/stores")
            .bodyAsText()
    }
}

