//
//  SplashView.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/01.
//

import ComposableArchitecture
import SwiftUI

struct SplashView: View {
    let store: StoreOf<SplashFeature>

    var body: some View {
        ZStack {
            SplashAnimationView(store: store)

            if let loadError = store.loadError {
                VStack {
                    Spacer()
                    Text(loadError)
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .padding()
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    SplashView(
        store: Store(initialState: SplashFeature.State()) {
            SplashFeature()
        } withDependencies: {
            $0.cheapSharkClient = .previewValue
        }
    )
}
