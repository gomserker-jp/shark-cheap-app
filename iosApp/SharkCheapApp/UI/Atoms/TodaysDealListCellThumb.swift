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
  let width: CGFloat
  let height: CGFloat

  var body: some View {
    KFImage(imageURL)
      .placeholder {
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.gray.opacity(0.2))
          .frame(width: width, height: height)
      }
      .fade(duration: 0.2)
      .resizable()
      .frame(width: width, height: height)
      .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}

#Preview {
  TodaysDealListCellThumb(
    imageURL: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg"),
    width: 343,
    height: 257
  )
  .padding()
}
