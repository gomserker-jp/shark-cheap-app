//
//  SearchBarView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/08.
//

import SwiftUI

struct SearchBarView: View {
    private static let contentPadding: CGFloat = 12

    @Binding var text: String
    let placeholder: String
    let onSubmit: () -> Void
    var onClear: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.secondary)

                TextField(placeholder, text: $text)
                    .font(.system(size: 16))
                    .submitLabel(.search)
                    .onSubmit(onSubmit)

                if !text.isEmpty {
                    Button {
                        text = ""
                        onClear?()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 16))
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Clear search")
                }
            }
            .padding(.horizontal, Self.contentPadding)
            .padding(.vertical, Self.contentPadding)
            .background(Color.gray.opacity(0.15), in: RoundedRectangle(cornerRadius: 12))

            Text("• \(L10n.Search.description)")
                .font(.footnote)
                .foregroundStyle(.primary)
                .padding(.horizontal, Self.contentPadding)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var text = "LEGO"

        var body: some View {
            SearchBarView(
                text: $text,
                placeholder: L10n.Search.placeholder,
                onSubmit: {},
                onClear: { text = "" }
            )
            .padding()
        }
    }

    return PreviewWrapper()
}
