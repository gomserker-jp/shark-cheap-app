//
//  CheapSharkClient+Live.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import Foundation
import RealmSwift
import SharedLogic

extension CheapSharkClient {
  static let liveValue = CheapSharkClient(
    fetchStores: {
      try await CheapSharkBridge().fetchStores().map(StoreItem.init(store:))
    },
    saveStores: { stores in
      try await MainActor.run {
        let realm = try Realm()
        try realm.write {
          for store in stores {
            realm.add(StoreMaster(storeItem: store), update: .modified)
          }
        }
      }
    }
  )
}
