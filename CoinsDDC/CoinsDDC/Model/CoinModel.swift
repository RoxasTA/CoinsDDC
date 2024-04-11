//
//  CoinModel.swift
//  CoinsDDC
//
//  Created by Victor Assis on 11/04/24.
//

import Foundation

struct CurrencyExchangeRate: Codable {
    let result: String
    let baseCode: String
    let conversionRates: [String: Double]
}
