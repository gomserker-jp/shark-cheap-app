//
//  SearchDetailInfoView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/12.
//

import SwiftUI

struct SearchDetailInfoView: View {
    let gameId: String
    let title: String
    let thumb: URL?
    let salePrice: Double
    let normalPrice: Double
    let cheapestPriceEverPrice: Double

    private let separatorColor = Color.gray.opacity(0.3)
    private let thumbWidth: CGFloat = 88
    private let thumbHeight: CGFloat = 72

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                VStack(spacing: 8) {
                    CommonListCellThumb(
                        imageURL: thumb,
                        width: thumbWidth,
                        height: thumbHeight
                    )

                    FavoriteLabelButton()
                }
                .frame(width: thumbWidth)
                .alignmentGuide(.top) { dimensions in
                    dimensions[VerticalAlignment.center]
                }

                VStack(alignment: .leading, spacing: 10) {
                    CommonTitleLabel(title: title)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    CommonPriceLabel(
                        salePrice: salePrice,
                        normalPrice: normalPrice
                    )

                    Text("Historical Low \(formatPrice(cheapestPriceEverPrice))")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .alignmentGuide(.top) { dimensions in
                    dimensions[VerticalAlignment.center]
                }
            }
            .padding(.leading, 12)
            .padding(.trailing, 12)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)

            Rectangle()
                .fill(separatorColor)
                .frame(height: 1)
        }
        .background(Asset.contentBackground.swiftUIColor)
    }

    private func formatPrice(_ price: Double) -> String {
        String(format: "$%.2f", price)
    }
}

#Preview {
    SearchDetailInfoView(
        gameId: "135457",
        title: "Counter-Strike 2",
        thumb: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg"),
        salePrice: 7.49,
        normalPrice: 14.99,
        cheapestPriceEverPrice: 3.99
    )
}
