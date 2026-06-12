//
//  MiddleSectionTitleLabel.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import SwiftUI

struct MiddleSectionTitleLabel: View {
    let title: String
    let storeId: String
    let logoURL: URL?

    var body: some View {
        HStack(spacing: 8) {
            StoreLogoView(storeId: storeId, size: 28, logoURL: logoURL)

            Text(title)
                .font(.system(size: 24, weight: .semibold))
        }
    }
}

#Preview {
    MiddleSectionTitleLabel(
        title: "Steam",
        storeId: "1",
        logoURL: URL(string: "https://www.cheapshark.com/images/stores/logos/0.png")
    )
}
