//
//  CommonPriceLabel.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/12.
//

import SwiftUI

struct CommonPriceLabel: View {
    let salePrice: Double
    let normalPrice: Double

    var body: some View {
        HStack(spacing: 8) {
            Text(formatPrice(salePrice))
                .font(.system(size: 32, weight: .semibold))
                .foregroundStyle(Asset.discountRateBackground.swiftUIColor)

            Text(formatPrice(normalPrice))
                .font(.system(size: 16, weight: .light))
                .foregroundStyle(.secondary)
                .strikethrough()
        }
    }

    private func formatPrice(_ price: Double) -> String {
        String(format: "$%.2f", price)
    }
}

#Preview {
    CommonPriceLabel(salePrice: 7.49, normalPrice: 14.99)
        .padding()
        .background(Asset.contentBackground.swiftUIColor)
}
