//
//  HomeTodaysDealThumbView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import SwiftUI

struct HomeTodaysDealThumbView: View {
    private static let cornerRadius: CGFloat = 12

    let imageURL: URL?
    let storeId: String
    let discountRate: Int
    let salePrice: Double
    let normalPrice: Double

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
        .overlay(alignment: .topLeading) {
            DiscountRateBadge(rate: discountRate, fontSize: 20)
                .padding(8)
        }
        .overlay(alignment: .topTrailing) {
            StoreLogoView(storeId: storeId, size: 40)
                .padding(8)
        }
        .overlay(alignment: .bottom) {
            LinearGradient(
                colors: [.clear, .black.opacity(0.7)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: thumbHeight * 0.5)
        }
        .overlay(alignment: .bottomLeading) {
            DealPriceLabel(
                salePrice: salePrice,
                normalPrice: normalPrice,
                style: .large
            )
            .padding(8)
        }
        .frame(width: contentWidth, height: thumbHeight)
        .clipShape(RoundedRectangle(cornerRadius: Self.cornerRadius))
    }
}

#Preview {
    HomeTodaysDealThumbView(
        imageURL: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg"),
        storeId: "1",
        discountRate: 75,
        salePrice: 7.49,
        normalPrice: 14.99
    )
    .padding(.horizontal, 16)
}
