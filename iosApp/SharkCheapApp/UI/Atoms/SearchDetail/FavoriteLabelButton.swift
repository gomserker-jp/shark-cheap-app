//
//  FavoriteLabelButton.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/12.
//

import SwiftUI

struct FavoriteLabelButton: View {
    var isFavorited = false
    var action: () -> Void = {}

    private var title: String {
        isFavorited ? L10n.SearchDetail.Favorite.alreadyDid : L10n.SearchDetail.Favorite.title
    }

    var body: some View {
        Button(action: action) {
            Group {
                if isFavorited {
                    Text(title)
                } else {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                        Text(title)
                    }
                }
            }
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background { backgroundShape }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
    }

    private var foregroundColor: Color {
        isFavorited ? Asset.Colors.textPrimary.swiftUIColor : .white
    }

    @ViewBuilder
    private var backgroundShape: some View {
        if isFavorited {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Asset.accentColor.swiftUIColor, lineWidth: 1)
                }
        } else {
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    LinearGradient(
                        colors: [
                            Asset.accentColor.swiftUIColor,
                            Asset.Colors.accentPressed.swiftUIColor,
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        FavoriteLabelButton()
        FavoriteLabelButton(isFavorited: true)
    }
    .frame(width: 88)
    .padding()
    .background(Asset.contentBackground.swiftUIColor)
}
