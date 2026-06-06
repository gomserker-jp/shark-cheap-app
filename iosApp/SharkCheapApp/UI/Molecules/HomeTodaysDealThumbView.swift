//
//  HomeTodaysDealThumbView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import SwiftUI

struct HomeTodaysDealThumbView: View {
    let imageURL: URL?
    let storeId: String
    let discountRate: Int

    private var contentWidth: CGFloat {
        UIScreen.main.bounds.width - 32
    }

    private var thumbHeight: CGFloat {
        contentWidth * 0.75
    }

    var body: some View {
        TodaysDealListCellThumb(
            imageURL: imageURL,
            width: contentWidth,
            height: thumbHeight
        )
        .overlay(alignment: .bottomLeading) {
            DiscountRateBadge(rate: discountRate, fontSize: 24)
                .padding(8)
        }
        .overlay(alignment: .topTrailing) {
            StoreLogoView(storeId: storeId, size: 40)
                .padding(8)
        }
        .frame(width: contentWidth, height: thumbHeight)
    }
}

#Preview {
    HomeTodaysDealThumbView(
        imageURL: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg"),
        storeId: "1",
        discountRate: 75
    )
    .padding(.horizontal, 16)
}
