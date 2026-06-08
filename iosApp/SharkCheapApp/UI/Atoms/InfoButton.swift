//
//  InfoButton.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/08.
//

import SwiftUI

struct InfoButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "info.circle")
                .font(.system(size: 18))
                .foregroundStyle(.secondary)
                .frame(width: 18, height: 18)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Info")
    }
}

#Preview {
    InfoButton {}
}
