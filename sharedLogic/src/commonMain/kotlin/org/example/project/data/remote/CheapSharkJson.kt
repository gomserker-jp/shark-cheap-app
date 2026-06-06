package org.example.project.data.remote

import kotlinx.serialization.json.Json

object CheapSharkJson {
    val instance: Json = Json {
        ignoreUnknownKeys = true
        isLenient = true
        coerceInputValues = true
    }
}
