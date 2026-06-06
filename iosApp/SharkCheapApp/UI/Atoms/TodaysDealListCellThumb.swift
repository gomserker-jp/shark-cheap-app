//
//  TodaysDealListCellThumb.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import Kingfisher
import SwiftUI

struct TodaysDealListCellThumb: View {
  let imageURL: URL?

  var body: some View {
    Color.clear
      .aspectRatio(4 / 3, contentMode: .fit)
      .frame(maxWidth: .infinity)
      .background(Color.gray.opacity(0.2))
      .overlay {
        KFImage(imageURL)
          .fade(duration: 0.2)
          .resizable()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
      .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}

#Preview {
  TodaysDealListCellThumb(
    imageURL: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg")
  )
}
