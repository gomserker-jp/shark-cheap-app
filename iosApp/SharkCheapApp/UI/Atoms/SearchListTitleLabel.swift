//
//  SearchListTitleLabel.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/08.
//

import SwiftUI

struct SearchListTitleLabel: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 18, weight: .regular))
    }
}

#Preview {
    SearchListTitleLabel(title: "Counter Strike 2")
}
