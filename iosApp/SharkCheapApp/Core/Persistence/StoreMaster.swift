//
//  StoreMaster.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/05.
//

import Foundation
import RealmSwift

final class StoreMaster: Object {
  @Persisted(primaryKey: true) var id: String = ""
  @Persisted var name: String = ""
  @Persisted var isActive: Bool = false
  @Persisted var bannerUrl: String = ""
  @Persisted var logoUrl: String = ""
  @Persisted var iconUrl: String = ""

  convenience init(storeItem: StoreItem) {
    self.init()
    id = storeItem.id
    name = storeItem.name
    isActive = storeItem.isActive
    bannerUrl = storeItem.bannerUrl
    logoUrl = storeItem.logoUrl
    iconUrl = storeItem.iconUrl
  }
}
