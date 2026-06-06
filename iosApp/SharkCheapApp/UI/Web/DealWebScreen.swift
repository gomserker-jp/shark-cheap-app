//
//  DealWebScreen.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import SwiftUI

struct DealWebScreen: View {
    let url: URL

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            WebView(url: url)
                .ignoresSafeArea()

            BackwardButton()
                .padding(.leading, 24)
                .padding(.bottom, 24)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    DealWebScreen(url: URL(string: "https://www.cheapshark.com")!)
}
