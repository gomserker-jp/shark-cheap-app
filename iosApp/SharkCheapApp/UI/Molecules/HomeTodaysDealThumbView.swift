//
//  HomeTodaysDealThumbView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import SwiftUI

struct HomeTodaysDealThumbView: View {
  let imageURL: URL?
  let discountRate: Int

  var body: some View {
    TodaysDealListCellThumb(imageURL: imageURL)
      .overlay(alignment: .bottomLeading) {
        DiscountRateBadge(rate: discountRate, fontSize: 24)
          .padding(8)
      }
      .padding(.horizontal, 16)
  }
}

#Preview {
  HomeTodaysDealThumbView(
    imageURL: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg"),
    discountRate: 75
  )
  .padding()
}
