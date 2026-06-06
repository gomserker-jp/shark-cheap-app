//
//  StoreDealThumbView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import SwiftUI

struct StoreDealThumbView: View {
    static let width: CGFloat = 200
    static let height: CGFloat = 125
    private static let cornerRadius: CGFloat = 12

    let imageURL: URL?
    let discountRate: Int
    let salePrice: Double
    let normalPrice: Double

    var body: some View {
        StoreDealListCellThumb(
            imageURL: imageURL,
            width: Self.width,
            height: Self.height
        )
        .overlay(alignment: .topLeading) {
            DiscountRateBadge(rate: discountRate, fontSize: 14)
                .padding(6)
        }
        .overlay(alignment: .bottom) {
            LinearGradient(
                colors: [.clear, .black.opacity(0.65)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: Self.height * 0.5)
        }
        .overlay(alignment: .bottomLeading) {
            DealPriceLabel(
                salePrice: salePrice,
                normalPrice: normalPrice,
                style: .compact
            )
            .padding(6)
        }
        .frame(width: Self.width, height: Self.height)
        .clipShape(RoundedRectangle(cornerRadius: Self.cornerRadius))
    }
}

#Preview {
    StoreDealThumbView(
        imageURL: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg"),
        discountRate: 75,
        salePrice: 7.49,
        normalPrice: 14.99
    )
}
