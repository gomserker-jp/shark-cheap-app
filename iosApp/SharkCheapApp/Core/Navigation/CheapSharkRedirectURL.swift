//
//  CheapSharkRedirectURL.swift
//  SharkCheapApp
//
//  Created by Gomserker on 2026/06/06.
//

import Foundation

enum CheapSharkRedirectURL {
    private static let baseURL = "https://www.cheapshark.com/redirect"

    static func deal(id: String) -> URL? {
        URL(string: "\(baseURL)?dealID=\(id)")
    }
}
