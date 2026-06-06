//
//  StoreDealSeeMoreCell.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import SwiftUI

struct StoreDealSeeMoreCell: View {
    static var width: CGFloat { StoreDealThumbView.width / 3 }
    static let height: CGFloat = StoreDealThumbView.height

    let storeId: String

    var body: some View {
        Button {
            // TODO: Navigate to store deals list screen
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.15))
                .frame(width: Self.width, height: Self.height)
                .overlay {
                    VStack(spacing: 2) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                        Text(L10n.StoreDeal.seeMore)
                            .font(.system(size: 11, weight: .semibold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .foregroundStyle(.secondary)
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    StoreDealSeeMoreCell(storeId: "1")
}
