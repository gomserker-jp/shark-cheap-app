//
//  SplashAnimationView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/05.
//

import ComposableArchitecture
import SwiftUI

struct SplashAnimationView: View {
    let store: StoreOf<SplashFeature>

    @State private var logoOffsetY: CGFloat = 0

    private let logoWidth: CGFloat = 400
    private let logoHeight: CGFloat = 250
    private let springResponse: TimeInterval = 0.5

    var body: some View {
        GeometryReader { geometry in
            let startOffsetY = geometry.size.height / 2 + logoHeight / 2

            Image(asset: Asset.appLogo)
                .resizable()
                .scaledToFit()
                .frame(width: logoWidth, height: logoHeight)
                .offset(y: logoOffsetY)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    logoOffsetY = startOffsetY
                }
                .onChange(of: store.displayState) { _, newValue in
                    switch newValue {
                    case .loading:
                        logoOffsetY = startOffsetY

                    case .splashAnimation:
                        playSlideUpAnimation()

                    case .loadingCompleted:
                        logoOffsetY = 0
                    }
                }
        }
    }

    private func playSlideUpAnimation() {
        withAnimation(.spring(response: springResponse, dampingFraction: 0.75)) {
            logoOffsetY = 0
        }

        Task {
            try? await Task.sleep(for: .seconds(springResponse))
            store.send(.splashAnimationEnded)
        }
    }
}
