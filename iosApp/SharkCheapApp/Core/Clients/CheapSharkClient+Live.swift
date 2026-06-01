import Foundation
import SharedLogic

extension CheapSharkClient {
  static let liveValue = CheapSharkClient(
    fetchStores: {
      try await CheapSharkBridge().fetchStores().map(StoreItem.init(store:))
    }
  )
}
