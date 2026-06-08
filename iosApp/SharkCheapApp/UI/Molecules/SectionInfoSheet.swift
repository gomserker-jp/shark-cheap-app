//
//  SectionInfoSheet.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/08.
//

import SwiftUI

struct SectionInfoSheet: View {
    let title: String
    let description: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)

                Text(description)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .scrollBounceBehavior(.always)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .presentationDetents([.fraction(1.0 / 3.0)])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    SectionInfoSheet(
        title: "Today's Deal",
        description: "Today's Deal highlights deals with a Metacritic score of 80 or higher and a discount of 50% or more from all available deals."
    )
}
