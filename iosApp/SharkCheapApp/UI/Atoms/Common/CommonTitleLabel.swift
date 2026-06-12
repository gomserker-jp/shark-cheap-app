//
//  CommonTitleLabel.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/12.
//

import SwiftUI

struct CommonTitleLabel: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 28, weight: .black))
            .lineLimit(2)
            .truncationMode(.tail)
            .multilineTextAlignment(.leading)
    }
}

#Preview {
    VStack(spacing: 16) {
        CommonTitleLabel(title: "Counter Strike 2")
        CommonTitleLabel(
            title: "The Elder Scrolls V: Skyrim Special Edition with a Very Long Subtitle"
        )
        .frame(maxWidth: 200)
    }
    .padding()
}
