//
//  FavoriteButton.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/08.
//

import SwiftUI

struct FavoriteButton: View {
    var body: some View {
        Button {
        } label: {
            Image(systemName: "star")
                .font(.system(size: 18))
                .foregroundStyle(.secondary)
                .frame(width: 18, height: 18)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Favorite")
    }
}

#Preview {
    FavoriteButton()
}
