//
//  GameDetailView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import SwiftUI

struct GameDetailView: View {
    @Environment(\.dismiss) private var dismiss

    let gameId: String
    let title: String
    let thumb: URL?
    let salePrice: Double
    let normalPrice: Double
    let cheapestPriceEverPrice: Double

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack(spacing: 0) {
                navigationBar

                SearchDetailInfoView(
                    gameId: gameId,
                    title: title,
                    thumb: thumb,
                    salePrice: salePrice,
                    normalPrice: normalPrice,
                    cheapestPriceEverPrice: cheapestPriceEverPrice
                )

                CommonSpacer()

                List {
                    Text("Deal row placeholder")
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .listSectionSpacing(0)
                .environment(\.defaultMinListRowHeight, 0)
                .ignoresSafeArea(edges: .bottom)
                .padding(.bottom, 24)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Asset.contentBackground.swiftUIColor)

            BackwardButton()
                .padding(.leading, 24)
                .padding(.bottom, 24)
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }

    private var navigationBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(Asset.Colors.textPrimary.swiftUIColor)
                    .frame(width: 44, height: 44)
            }
            .accessibilityLabel("Back")

            Spacer()

            Image(asset: Asset.appLogo)
                .resizable()
                .scaledToFit()
                .frame(height: 32)

            Spacer()

            Color.clear
                .frame(width: 44, height: 44)
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
    }
}

#Preview {
    NavigationStack {
        GameDetailView(
            gameId: "135457",
            title: "Counter-Strike 2",
            thumb: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg"),
            salePrice: 7.49,
            normalPrice: 14.99,
            cheapestPriceEverPrice: 3.99
        )
    }
}
