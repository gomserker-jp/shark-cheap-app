//
//  StoreLogoView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import Kingfisher
import SwiftUI

struct StoreLogoView: View {
  let storeId: String
  let size: CGFloat

  @State private var logoURL: URL?

  var body: some View {
    Group {
      if let logoURL {
        KFImage(logoURL)
          .fade(duration: 0.2)
          .resizable()
          .scaledToFit()
          .frame(width: size, height: size)
          .padding(4)
          .clipShape(RoundedRectangle(cornerRadius: 8))
      }
    }
    .onAppear {
      logoURL = StoreMasterRepository.logoURL(for: storeId)
    }
  }
}

#Preview {
  StoreLogoView(storeId: "1", size: 40)
}
