import ComposableArchitecture
import Foundation

struct CheapSharkClient: Sendable {
  var fetchStores: @Sendable () async throws -> [StoreItem]

  init(
    fetchStores: @escaping @Sendable () async throws -> [StoreItem] = { [] }
  ) {
    self.fetchStores = fetchStores
  }
}

extension CheapSharkClient: DependencyKey {
  static let testValue = CheapSharkClient()
  static let previewValue = CheapSharkClient(
    fetchStores: {
      [
        StoreItem(
          id: "1",
          name: "Steam",
          logoUrl: "https://www.cheapshark.com/images/stores/logos/0.png"
        ),
      ]
    }
  )
}

extension DependencyValues {
  var cheapSharkClient: CheapSharkClient {
    get { self[CheapSharkClient.self] }
    set { self[CheapSharkClient.self] = newValue }
  }
}
