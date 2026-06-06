//
//  DiscountRateBadge.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import SwiftUI

struct DiscountRateBadge: View {
  let rate: Int
  let fontSize: CGFloat

  var body: some View {
    Text("\(rate)%")
      .font(.system(size: fontSize, weight: .bold))
      .foregroundStyle(.white)
      .padding(.vertical, 6)
      .padding(.horizontal, 12)
      .background {
        RoundedRectangle(cornerRadius: 8)
          .fill(Asset.discountRateBackground.swiftUIColor)
      }
  }
}

#Preview {
  DiscountRateBadge(rate: 75, fontSize: 32)
}
