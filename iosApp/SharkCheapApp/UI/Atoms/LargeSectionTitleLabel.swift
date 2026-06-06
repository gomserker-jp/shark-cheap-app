//
//  LargeSectionTitleLabel.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import SwiftUI

struct LargeSectionTitleLabel: View {
  let text: String

  var body: some View {
    Text(text)
      .font(.system(size: 32, weight: .bold))
  }
}

#Preview {
  LargeSectionTitleLabel(text: "Today's Deals")
}
