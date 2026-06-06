//
//  StoreMasterRepository.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import Foundation
import RealmSwift

enum StoreMasterRepository {
  static func logoURL(for storeId: String) -> URL? {
    guard
      let realm = try? Realm(),
      let store = realm.object(ofType: StoreMaster.self, forPrimaryKey: storeId),
      !store.logoUrl.isEmpty
    else {
      return nil
    }

    return URL(string: store.logoUrl)
  }
}
