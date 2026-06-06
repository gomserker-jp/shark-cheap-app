package org.example.project.data.remote

import io.ktor.client.HttpClient

object CheapSharkHttpClient {
    val client: HttpClient by lazy {
        createHttpClient()
    }
}
