//
//  SearchListCellView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/08.
//

import SwiftUI

struct SearchListCellView: View {
    let gameId: String
    let external: String
    let thumb: URL?
    var showsTopBorder = false

    private let borderColor = Color.gray.opacity(0.3)

    var body: some View {
        VStack(spacing: 0) {
            if showsTopBorder {
                Rectangle()
                    .fill(borderColor)
                    .frame(height: 1)
            }

            HStack(spacing: 16) {
                CommonListCellThumb(imageURL: thumb, width: 80, height: 60)

                SearchListTitleLabel(title: external)

                Spacer(minLength: 0)

                FavoriteButton()
            }
            .padding(.leading, 12)
            .padding(.vertical, 12)
            .padding(.trailing, 18)
            .frame(maxWidth: .infinity, alignment: .leading)

            Rectangle()
                .fill(borderColor)
                .frame(height: 1)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SearchListCellView(
        gameId: "1",
        external: "Counter Strike 2",
        thumb: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg")
    )
}
