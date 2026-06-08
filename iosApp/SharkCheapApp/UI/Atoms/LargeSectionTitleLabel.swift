//
//  LargeSectionTitleLabel.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import SwiftUI

struct LargeSectionTitleLabel: View {
    let text: String
    var infoMessage: String?

    @State private var isInfoSheetPresented = false

    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            Text(text)
                .font(.system(size: 32, weight: .bold))

            if infoMessage != nil {
                InfoButton { isInfoSheetPresented = true }
            }
        }
        .sheet(isPresented: $isInfoSheetPresented) {
            if let infoMessage {
                SectionInfoSheet(title: text, description: infoMessage)
            }
        }
    }
}

#Preview {
    LargeSectionTitleLabel(
        text: "Today's Deals",
        infoMessage: "Sample section description."
    )
}
