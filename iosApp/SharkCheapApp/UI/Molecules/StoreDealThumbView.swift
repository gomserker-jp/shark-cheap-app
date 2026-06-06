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

    let imageURL: URL?
    let discountRate: Int

    var body: some View {
        StoreDealListCellThumb(
            imageURL: imageURL,
            width: Self.width,
            height: Self.height
        )
        .overlay(alignment: .bottomLeading) {
            DiscountRateBadge(rate: discountRate, fontSize: 16)
                .padding(8)
        }
        .frame(width: Self.width, height: Self.height)
    }
}

#Preview {
    StoreDealThumbView(
        imageURL: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg"),
        discountRate: 75
    )
}
