//
//  BackwardButton.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import SwiftUI

struct BackwardButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.backward")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.primary)
                .frame(width: 48, height: 48)
                .background(.ultraThinMaterial, in: Circle())
        }
        .accessibilityLabel("Back")
    }
}

#Preview {
        BackwardButton()
}
