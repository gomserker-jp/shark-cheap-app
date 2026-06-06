//
//  StoreLogoView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import Kingfisher
import SwiftUI

struct StoreLogoView: View {
    let storeId: String
    let size: CGFloat
    let logoURL: URL?

    @State private var resolvedLogoURL: URL?

    init(storeId: String, size: CGFloat, logoURL: URL? = nil) {
        self.storeId = storeId
        self.size = size
        self.logoURL = logoURL
    }

    var body: some View {
        Group {
            if let resolvedLogoURL {
                KFImage(resolvedLogoURL)
                    .fade(duration: 0.2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.15))
                    .frame(width: size, height: size)
            }
        }
        .task(id: taskKey) {
            if let logoURL {
                resolvedLogoURL = logoURL
            } else {
                resolvedLogoURL = StoreMasterRepository.logoURL(for: storeId)
            }
        }
    }

    private var taskKey: String {
        "\(storeId)-\(logoURL?.absoluteString ?? "")"
    }
}

#Preview {
    StoreLogoView(storeId: "1", size: 40)
}
