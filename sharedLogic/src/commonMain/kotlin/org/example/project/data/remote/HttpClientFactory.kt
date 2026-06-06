package org.example.project.data.remote

import io.ktor.client.HttpClient

internal expect fun createHttpClient(): HttpClient
