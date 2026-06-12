//
//  CommonListCellThumb.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/08.
//

import Kingfisher
import SwiftUI

struct CommonListCellThumb: View {
    let imageURL: URL?
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        KFImage(imageURL)
            .placeholder {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: width, height: height)
            }
            .resizable()
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    CommonListCellThumb(
        imageURL: URL(string: "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg"),
        width: 120,
        height: 100)
}
