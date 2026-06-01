import Foundation
import SharedLogic

struct StoreItem: Equatable, Identifiable, Sendable {
  let id: String
  let name: String
  let logoUrl: String

  init(id: String, name: String, logoUrl: String) {
    self.id = id
    self.name = name
    self.logoUrl = logoUrl
  }

  init(store: SharedLogic.Store) {
    id = store.id
    name = store.name
    logoUrl = store.logoUrl
  }
}
