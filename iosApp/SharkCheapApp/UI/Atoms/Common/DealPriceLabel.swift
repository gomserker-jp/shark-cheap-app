//
//  DealPriceLabel.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import SwiftUI

struct DealPriceLabel: View {
    enum Style {
        case large
        case compact

        var saleFontSize: CGFloat {
            switch self {
            case .large: 32
            case .compact: 24
            }
        }

        var normalFontSize: CGFloat {
            switch self {
            case .large: 16
            case .compact: 12
            }
        }

        var spacing: CGFloat {
            switch self {
            case .large: 8
            case .compact: 4
            }
        }
    }

    let salePrice: Double
    let normalPrice: Double
    let style: Style

    var body: some View {
        HStack(spacing: style.spacing) {
            Text(formatPrice(salePrice))
                .font(.system(size: style.saleFontSize, weight: .semibold))
                .foregroundStyle(Asset.discountRateBackground.swiftUIColor)

            Text(formatPrice(normalPrice))
                .font(.system(size: style.normalFontSize, weight: .light))
                .foregroundStyle(.white.opacity(0.75))
                .strikethrough()
        }
    }

    private func formatPrice(_ price: Double) -> String {
        String(format: "$%.2f", price)
    }
}

#Preview {
    ZStack {
        Color.black
        DealPriceLabel(salePrice: 7.49, normalPrice: 14.99, style: .large)
    }
    .frame(height: 60)
}
